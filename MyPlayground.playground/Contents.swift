//: Playground - noun: a place where people can play

import UIKit
import Foundation

extension Int {
    static let incorrectString = -1
    
    static let romanDigitsDictionary = [1 : "I",
                                        4 : "IV",
                                        5 : "V",
                                        9 : "IX",
                                        10 : "X",
                                        40 : "XL",
                                        50 : "L",
                                        90 : "XC",
                                        100 : "C",
                                        400 : "CD",
                                        500 : "D",
                                        900 : "CM",
                                        1000 : "M"]
    
    func toRoman() -> String? {
        if self < 1 || self > 6_000 {
            return nil
        }
        var romeStr = ""
        let signs = self.signsArray()
        
        for i in 0..<signs.count {
            let mutiplier: Int = Int(NSDecimalNumber(decimal: pow(10, i)))
            let currSign = signs[i] * mutiplier
            
            romeStr = currSign.currentSignRomanString() + romeStr
            
        }
        print(romeStr)
        
        return romeStr
    }
    
    func currentSignRomanString() -> String {
        var allKeys = Array(Int.romanDigitsDictionary.keys)
        allKeys = allKeys.sorted(by: {
            $0 < $1
        })
        var rString = ""
        
        if self > RomanDigit.Thousand.toInt() {
            let key = allKeys.last!
            let currSign = Int.romanDigitsDictionary[key]
            let count = self / RomanDigit.Thousand.toInt()
            for i in 0..<count {
                rString = rString + currSign!
            }
            return rString
        }
        
        if allKeys.contains(self) {
            return Int.romanDigitsDictionary[self]!
        }
        
        let romanClassSigns = ["I", "X", "C", "M"]
        
        for i in 0..<allKeys.count - 1 {
            let currKey = allKeys[i]
            let nextKey = allKeys[i + 1]
            if currKey < self && nextKey > self {
                var sign = Int.romanDigitsDictionary[currKey]
                var count = 1
                if romanClassSigns.contains(sign!) {
                    count = self / currKey
                } else {
                    rString.append(sign!)
                    let prevKey = allKeys[i - 2]
                    sign = Int.romanDigitsDictionary[prevKey]
                    count = (self - currKey) / prevKey
                }
                for i in 0..<count {
                    rString = rString + sign!
                }
                
                return rString
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
}



let intDigit: Int = 641
let romeStr = intDigit.toRoman()
print("\(intDigit) = \(romeStr) in Roman numerals")


let romanDigit = "XCIV"
let arabDigit = Int.arabianNumber(romeDigitStr: romanDigit)
print("\(romanDigit) = \(arabDigit)")

