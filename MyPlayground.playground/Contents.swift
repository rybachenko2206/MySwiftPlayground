//: Playground - noun: a place where people can play

import UIKit
import Foundation

extension Int {
    static let incorrectString = -1
    static let romanDigitMax = 3_999
    
    func romanNumber() -> String? {
        if self < 1 || self > Int.romanDigitMax {
            return nil
        }
        var romeStr = ""
        let signs = self.signsArray()
        
        for i in 0..<signs.count {
            let currSign = signs[i]
            
            romeStr = currSign.currentSignRomanString(digitPlace: i) + romeStr
        }
        
        return romeStr
    }
    
    func currentSignRomanString(digitPlace: Int) -> String {
        var rString = ""
        
        let symbolsArray = RomanDigit.symbolsForDigitPlace(place: digitPlace)
        if symbolsArray.count == 1 {
            let maxDigitThousand = Int.romanDigitMax / 1_000
            for i in 0..<maxDigitThousand {
                rString.append(symbolsArray.last!.rawValue)
            }
        } else if symbolsArray.count > 1 {
            switch self {
            case 1:
                rString.append(symbolsArray[0].rawValue)
            case 2:
                let sign = String(symbolsArray[0].rawValue)
                rString = sign + sign
            case 3:
                let sign = String(symbolsArray[0].rawValue)
                rString = sign + sign + sign
            case 4:
                rString = String(symbolsArray[0].rawValue) + String(symbolsArray[1].rawValue)
            case 5:
                rString = String(symbolsArray[1].rawValue)
            case 6:
                let firstSign = String(symbolsArray[1].rawValue)
                let otherSign = String(symbolsArray[0].rawValue)
                rString = firstSign + otherSign
            case 7:
                let firstSign = String(symbolsArray[1].rawValue)
                let otherSign = String(symbolsArray[0].rawValue)
                rString = firstSign + otherSign + otherSign
            case 8:
                let firstSign = String(symbolsArray[1].rawValue)
                let otherSign = String(symbolsArray[0].rawValue)
                rString = firstSign + otherSign + otherSign + otherSign
            case 9:
                rString =  String(symbolsArray[0].rawValue) +  String(symbolsArray[2].rawValue)
            default: break
                
            }
        }
        
        return rString
    }
    
    
    static func arabianNumber(romeDigitStr: String) -> Int? {
        var arabDigit: Int = 0
        for i in 0..<romeDigitStr.characters.count {
            let char = romeDigitStr.characterAtIndex(index: i)
            guard let romanLetter = RomanDigit(rawValue: char!) else {
                print("\n\n~~incorrect value")
                return nil
            }
            
            var nextLetter: RomanDigit? = nil
            if let nextChar = romeDigitStr.characterAtIndex(index: i + 1) {
                nextLetter = RomanDigit(rawValue: nextChar)
            }
            
            let currentInt = romanLetter.toInt()
            if romanLetter.shoudAddForNext(nextDigit: nextLetter) == true {
                arabDigit += currentInt
            } else {
                arabDigit -= currentInt
            }
        }
        return arabDigit
    }
    
    func signsArray() -> [Int] {
        var number = self
        var signs = [Int]()
        
        while number != 0 {
            let sign = number % 10
            signs.append(sign)
            number /= 10
        }
        
        return signs
    }
}

extension String {
    func characterAtIndex(index: Int) -> Character? {
        if index >= self.characters.count {
            return nil
        }
        let i = self.index(self.startIndex, offsetBy: index)
        
        return self.characters[i]
    }
}


enum RomanDigit: Character {
    case One = "I"
    case Five = "V"
    case Ten = "X"
    case Fifty = "L"
    case Hundred = "C"
    case FiveHundreds = "D"
    case Thousand = "M"
    
    func toInt() -> Int {
        switch self {
        case .One: return 1
        case .Five: return 5
        case .Ten: return 10
        case .Fifty: return 50
        case .Hundred: return 100
        case .FiveHundreds: return 500
        case .Thousand: return 1_000
        }
    }
    
    func shoudAddForNext(nextDigit: RomanDigit?) -> Bool {
        if nextDigit == nil {
            return true
        }
        if nextDigit!.toInt() > self.toInt() {
            return false
        }
        return true
    }
    
    static func symbolsForDigitPlace(place: Int) -> [RomanDigit] {
        if place == 0 {
            return [.One, .Five, .Ten]
        } else if place == 1 {
            return [.Ten, .Fifty, .Hundred]
        } else if place == 2 {
            return [.Hundred, .FiveHundreds, .Thousand]
        } else {
            return [.Thousand]
        }
    }
}



let intDigit: Int = 641
let romeStr = intDigit.romanNumber()
print("\(intDigit) = \(romeStr) in Roman numerals")


let romanDigit = "XCIV"
let arabDigit = Int.arabianNumber(romeDigitStr: romanDigit)
print("\(romanDigit) = \(arabDigit)")

