//
//  Int+Five.swift
//  FiveUtils
//
//  Created by Denis Mendica on 5/27/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation

// MARK: Ordinal
extension Int {
    
    /**
     Returns a string that represents this integer as an ordinal number, e.g. "1st" for 1, "2nd" for 2 etc.
    */
    public var ordinalString: String {
        let ones = self % 10
        let tens = self / 10 % 10
        
        var suffix: String
        if tens == 1 {
            suffix = "th"
        } else if ones == 1 {
            suffix = "st"
        } else if ones == 2 {
            suffix = "nd"
        } else if ones == 3 {
            suffix = "rd"
        } else {
            suffix = "th"
        }
        
        return String(self) + suffix
    }
}
