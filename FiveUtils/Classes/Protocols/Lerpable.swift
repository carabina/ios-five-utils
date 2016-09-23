//
//  Lerpable.swift
//  FiveUtils
//
//  Created by Miran Brajsa on 16/09/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import CoreGraphics
import Foundation

public protocol Lerpable {

    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self

    func scale(by value: CGFloat) -> Self
}

extension CGFloat: Lerpable {
    
    public func scale(by value: CGFloat) -> CGFloat {
        return self * value
    }
}

extension Double: Lerpable {
    
    public func scale(by value: CGFloat) -> Double {
        return Double(CGFloat(self) * value)
    }
}

extension Float: Lerpable {
    
    public func scale(by value: CGFloat) -> Float {
        return Float(CGFloat(self) * value)
    }
}

extension Int: Lerpable {
    
    public func scale(by value: CGFloat) -> Int {
        return Int(CGFloat(self) * value)
    }
}
