//
//  Array+Five.swift
//  FiveUtils
//
//  Created by Miran Brajsa on 08/03/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation

// MARK: Safe
extension Array {

    /**
     Allows for returning of 'nil' values in case a specified index is out of bounds.
     
     - parameter index: Index of array element to return.
     - returns: Array element or 'nil' if index is out of array bounds.
     */
    public subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil;
    }
}

// MARK: Random element
extension Array {
    
    /**
     Returns a random element.
     
     - returns: Random array element.
     */
    
    public func randomElement() -> Element {
        return self[Random.from(0..<self.count)]
    }
}

// MARK: Archiver
extension Array {
    
    /**
     Archives the array into user defaults.
     
     - parameter key: A key for our array.
     */
    public func archive(_ key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: self as AnyObject)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    /**
     Tries to unarchive the array. If unsuccessfull, returns nil.
     
     - parameter key: A key for our array.
     - returns: The unarchived array or 'nil' in case of an error.
     */
    
    public static func unarchive(_ key: String) -> Array? {
        if
            let arrayData = UserDefaults.standard.object(forKey: key) as? Data,
            let array = NSKeyedUnarchiver.unarchiveObject(with: arrayData) as? [Element] {
                return array
        }
        return nil
    }
}
