//
//  Random.swift
//  Pods
//
//  Created by Miran Brajsa on 25/03/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import CoreGraphics
import Foundation

public class Random {

    /**
     Returns a random CGFloat value specified in the [from, to) set. If no values get specified,
     the default set is [0.0, 1.0). The method allows for set bounds to be inverted meaning
     upper set bound may be set to smaller number than lower bound.
     
     - parameter from: Lower set bound.
     - parameter to: Upper set bound.
     - returns: A random CGFloat value in set [from, to). Default set is [0.0, 1.0).
     */
    public static func random(_ from: CGFloat = 0, to: CGFloat = 1.0) -> CGFloat {
        let randomValue = CGFloat(drand48())
        
        let result = Math.lerp(from: from, to: to, t: randomValue)
        return result
    }
    
    /**
     Returns a random Int value from a specified open range.
     
     - parameter range: A range.
     - returns: A random Int value in range [from, to).
     */
    public static func from(_ range: Range<Int>) -> Int {
        return from(range.lowerBound, to: range.upperBound)
    }

    /**
     Returns a random Int value between two values.
     
     - parameter from: Includive lower bound.
     - parameter to: Exclusive upper bound.
     - returns: A random Int value in range [from, to).
     */
    public static func from(_ from: Int, to: Int) -> Int {
        let result = Math.lerp(from: from, to: to, t: random())
        return result
    }

    /**
     Returns a random character from a set of lowercase English letters, uppercase English letters, and digits 0-9.
    */
    public static func alphanumericCharacter() -> Character {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomIndex = Int(arc4random_uniform(UInt32(characters.characters.count)))
        return characters[characters.characters.index(characters.startIndex, offsetBy: randomIndex)]
    }
    
    /**
     Builds a random string from a set of lowercase English letters, uppercase English letters, and digits 0-9.
     
     - parameter length: length of the resulting string.
     - returns: A random string of a specified length.
    */
    public static func alphanumericString(withLength length: Int) -> String {
        var string = ""
        for _ in 0..<length {
            string += String(Random.alphanumericCharacter())
        }
        
        return string
    }
}
