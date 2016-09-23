//
//  Math.swift
//  LaLaLunchbox
//
//  Created by Niko Mikulicic on 3/29/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation

public class Math {

    /**
     Clamps value between lower and upper bound.
     - parameter between: Lower bound.
     - parameter and: Upper bound.
     - returns: New clamped value.
     */
    public static func clamp<T: Comparable>(_ value: T, between lower: T, and upper: T) -> T {
        return min(max(value, lower), upper)
    }
    
    /**
     Interpolates linearly between initial and target value.
     - parameter from: Initial value for t = 0.
     - parameter second: Target value for t = 1.
     - parameter t: Interpolation parameter.
     - returns: New value between initial and target values based on interpolation paramater.
     */
    public static func lerp<T: Lerpable>(from first: T, to second: T, t: CGFloat) -> T {
        return first + (second - first).scale(by: t)
    }
}
