//
//  FiveUtilsTests.swift
//  FiveUtilsTests
//
//  Created by Miran Brajsa on 18/09/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import CoreGraphics
import FiveUtils
import XCTest

class FiveUtilsTests: XCTestCase {
    
    fileprivate let dummyArray = [1, 2, 3, 4, 5]
    fileprivate let testRepetitionCount = 100
    
    func testSafeArray() {
        XCTAssert(dummyArray[safe: 1] == 2, "Safe subscript should return actual element if inside of bounds.")
        XCTAssert(dummyArray[safe: 15] == nil, "Safe subscript should not crash the app but return 'nil' instead.")
    }
    
    func testArrayArchiver() {
        let key = "archiveKey"
        
        dummyArray.archive(key)
        guard let unarchivedArray = Array<Int>.unarchive(key) else {
            XCTAssert(false, "Array must be unarchived successfully.")
            return
        }
        
        XCTAssert(unarchivedArray == dummyArray, "Arrays must be equal.")
    }
    
    func testArrayRandomElement() {
        for _ in 0..<testRepetitionCount {
            let randomElement = dummyArray.randomElement()
            XCTAssert(dummyArray.contains(randomElement), "Array should contain randomly chosen element.")
        }
    }
    
    func testRandom() {
        for _ in 0..<testRepetitionCount {
            let random = Random.random()
            XCTAssert(random >= 0.0 && random < 1.0,
                      "Generated value should be in the [0.0, 1.0) set. Actual value is: \(random)")
            
            let randomInCustomSet = Random.random(30.0, to: 40.0)
            XCTAssert(randomInCustomSet >= 30.0 && randomInCustomSet < 40.0,
                      "Generated value should be in the [30.0, 40.0) set. Actual value is: \(randomInCustomSet)")
            
            let randomInCustomSetWithNegativeBase = Random.random(-10.0, to: 10.0)
            XCTAssert(randomInCustomSetWithNegativeBase >= -10.0 && randomInCustomSetWithNegativeBase < 10.0,
                      "Generated value should be in the [-10, 10.0) set. Actual value is: \(randomInCustomSetWithNegativeBase)")
            
            let randomDescendingFloatIntervalValue = Random.random(4.0, to: 1.0)
            XCTAssert(randomDescendingFloatIntervalValue > 1 && randomDescendingFloatIntervalValue <= 4,
                      "Generated value should be in the [4, 1) set. Actual value is: \(randomDescendingFloatIntervalValue)")

            let randomRangeValue = Random.from(0..<5)
            XCTAssert(randomRangeValue >= 0 && randomRangeValue < 5,
                      "Generated value should be in the [0, 5) set. Actual value is: \(randomRangeValue)")
            
            let randomDescendingIntIntervalValue = Random.from(15, to: 3)
            XCTAssert(randomDescendingIntIntervalValue > 3 && randomDescendingIntIntervalValue <= 15,
                      "Generated value should be in the [15, 3) set. Actual value is: \(randomDescendingIntIntervalValue)")

            let randomNegativeIntervalValue = Random.from(-15, to: 3)
            XCTAssert(randomNegativeIntervalValue >= -15 && randomNegativeIntervalValue < 3,
                      "Generated value should be in the [-15, 3) set. Actual value is: \(randomNegativeIntervalValue)")

            let randomIntervalValueWithNegativeBase = Random.from(-10..<10)
            XCTAssert(randomIntervalValueWithNegativeBase >= -10 && randomIntervalValueWithNegativeBase < 10,
                      "Generated value should be in the [-10, 10) set. Actual value is: \(randomIntervalValueWithNegativeBase)")
        }
    }
    
    func testRandomAlphanumericCharacter() {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        for _ in 0..<testRepetitionCount {
            XCTAssertTrue(characters.contains(String(Random.alphanumericCharacter())), "Character must be a lowercase English letter, uppercase English letter, or digit 0-9.")
        }
    }
    
    func testRandomAlphanumericString() {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        for i in 0..<testRepetitionCount {
            for character in Random.alphanumericString(withLength: i).characters {
                XCTAssertTrue(characters.contains(String(character)), "Each character in a string must be a lowercase English letter, uppercase English letter, or digit 0-9.")
            }
        }
    }
    
    func testClamp() {
        let clampedFloatValue: Float = Math.clamp(-1.0, between: 0.0, and: 1.0)
        XCTAssertEqual(clampedFloatValue, 0, "Clamped value should always be higher or equal to the lower bound.")
        
        let clampedIntValue = Math.clamp(2, between: 0, and: 1)
        XCTAssertEqual(clampedIntValue, 1, "Clamped value should always be lower or equal to the upper bound.")
        
        let clampedDoubleValue = Math.clamp(0.2, between: 0.0, and: 1.0)
        XCTAssertEqual(clampedDoubleValue, 0.2, "Value should remain unchanged if it's between lower and upper bound.")
    }
    
    func testFiveTimeInterval() {
        let weeks = 1
        let days = 10
        let hours = 36
        let minutes = 90
        let seconds: Double = 90
        let interval = FiveTimeInterval(weeks: weeks, days: days, hours: hours, minutes: minutes, seconds: seconds)
        
        let totalSeconds = Double(weeks * 7 * 24 * 60 * 60) + Double(days * 24 * 60 * 60) + Double(hours * 60 * 60) + Double(minutes * 60) + seconds
        XCTAssertEqual(interval.totalSeconds, totalSeconds)
        XCTAssertEqual(interval.totalMinutes, totalSeconds / 60)
        XCTAssertEqual(interval.totalHours, totalSeconds / 60 / 60)
        XCTAssertEqual(interval.totalDays, totalSeconds / 60 / 60 / 24)
        XCTAssertEqual(interval.totalWeeks, totalSeconds / 60 / 60 / 24 / 7)
        
        XCTAssertEqual(interval.second, 30)
        XCTAssertEqual(interval.minute, 31)
        XCTAssertEqual(interval.hour, 13)
        XCTAssertEqual(interval.day, 4)
        XCTAssertEqual(interval.week, 2)
    }
    
    func testOrdinalString() {
        XCTAssertEqual(1.ordinalString, "1st")
        XCTAssertEqual(2.ordinalString, "2nd")
        XCTAssertEqual(3.ordinalString, "3rd")
        XCTAssertEqual(4.ordinalString, "4th")
        XCTAssertEqual(11.ordinalString, "11th")
        XCTAssertEqual(12.ordinalString, "12th")
        XCTAssertEqual(13.ordinalString, "13th")
        XCTAssertEqual(25.ordinalString, "25th")
        XCTAssertEqual(92.ordinalString, "92nd")
        XCTAssertEqual(564.ordinalString, "564th")
        XCTAssertEqual(9813.ordinalString, "9813th")
        XCTAssertEqual(1000001.ordinalString, "1000001st")
    }
    
    func testNetworkActivityController() {
        let networkActivityController = FiveNetworkActivityController.shared
        XCTAssertTrue(networkActivityController.taskCount == 0)
        
        networkActivityController.startActivity()
        XCTAssertTrue(networkActivityController.taskCount == 1)
        
        networkActivityController.startActivity()
        XCTAssertTrue(networkActivityController.taskCount == 2)
        
        networkActivityController.startActivity()
        XCTAssertTrue(networkActivityController.taskCount == 3)
        
        networkActivityController.endActivity()
        XCTAssertTrue(networkActivityController.taskCount == 2)
        
        networkActivityController.startActivity()
        XCTAssertTrue(networkActivityController.taskCount == 3)
        
        networkActivityController.endActivity()
        XCTAssertTrue(networkActivityController.taskCount == 2)
        
        networkActivityController.endActivity()
        XCTAssertTrue(networkActivityController.taskCount == 1)
        
        networkActivityController.endActivity()
        XCTAssertTrue(networkActivityController.taskCount == 0)
    }
}
