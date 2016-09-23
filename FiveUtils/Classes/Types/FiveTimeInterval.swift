//
//  FiveTimeInterval.swift
//  FiveUtils
//
//  Created by Denis Mendica on 5/27/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation

public class FiveTimeInterval {
    
    fileprivate let timeInterval: TimeInterval
    
    /**
     Total number of seconds in this time interval.
     */
    public var totalSeconds: Double {
        return timeInterval
    }
    
    /**
     Total number of minutes in this time interval.
     */
    public var totalMinutes: Double {
        return totalSeconds / 60
    }
    
    /**
     Total number of hours in this time interval.
     */
    public var totalHours: Double {
        return totalMinutes / 60
    }
    
    /**
     Total number of days in this time interval.
     */
    public var totalDays: Double {
        return totalHours / 24
    }
    
    /**
     Total number of weeks in this time interval.
     */
    public var totalWeeks: Double {
        return totalDays / 7
    }
    
    /**
     Current second in a minute, from 0 to 59.
     */
    public var second: Int {
        return Int(totalSeconds) - Int(totalMinutes) * 60
    }
    
    /**
     Current minute in an hour, from 0 to 59.
     */
    public var minute: Int {
        return Int(totalMinutes) - Int(totalHours) * 60
    }
    
    /**
     Current hour in a day, from 0 to 23.
     */
    public var hour: Int {
        return Int(totalHours) - Int(totalDays) * 24
    }
    
    /**
     Current day in a week, from 0 to 6.
     */
    public var day: Int {
        return Int(totalDays) - Int(totalWeeks) * 7
    }
    
    /**
     Current week.
     */
    public var week: Int {
        return Int(totalWeeks)
    }
    
    /**
     Creates an FiveTimeInterval object that represents a given TimeInterval value.
     
     - parameter timeInterval: TimeInterval value to create the FiveTimeInterval instance from.
     */
    public init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    /**
     Creates an FiveTimeInterval object by summing up amounts of different time units.
     
     - parameter weeks: number of weeks to add to the interval.
     - parameter days: number of days to add to the interval.
     - parameter hours: number of hours to add to the interval.
     - parameter minutes: number of minutes to add to the interval.
     - parameter seconds: number of seconds to add to the interval.
     */
    public init(weeks: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Double = 0) {
        timeInterval =
            Double(weeks * 7 * 24 * 60 * 60) +
            Double(days * 24 * 60 * 60) +
            Double(hours * 60 * 60) +
            Double(minutes * 60) +
            seconds
    }
}
