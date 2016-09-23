//
//  ContentCellViewModel.swift
//  Example
//
//  Created by Miran Brajsa on 21/09/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation
import FiveUtils

struct SliderConfiguration {
    let minimumValue: Float
    let maximumValue: Float
    let startingValue: Float
}

class ContentCellViewModel {

    fileprivate let type: ContentCellType
    fileprivate let networkActivityController: FiveNetworkActivityController
    fileprivate let dummyArray: [Int]
    fileprivate let index: Int
    
    init(withType type: ContentCellType, index: Int, networkActivityController: FiveNetworkActivityController) {
        self.type = type
        self.index = index
        self.networkActivityController = networkActivityController

        var preparedArray = [Int]()
        for _ in 0..<4 {
            preparedArray.append(Random.from(-10..<30))
        }
        dummyArray = preparedArray
    }

    func updateButtonTapResult() -> String {
        switch type {
        case .randomGenerator:
            return String(format: "%.3f", generateRandomNumber())
        case .randomArrayElement:
            return "\(randomArrayElement())"
        case .clampedValue, .linearlyInterpolatedValue, .networkActivityController, .safeArray:
            return "0.000"
        }
    }

    func updateSliderResults(newValue: Float) -> (String, String) {
        switch type {
        case .networkActivityController:
            let newIntValue = Int(newValue)
            return ("\(updateNetworkActivityCount(count: newIntValue))", "0.000")
        case .safeArray:
            let newIntValue = Int(newValue)
            var arrayStringValue = "nil"
            if let arrayValue = safeArrayValue(for: newIntValue) {
                arrayStringValue = "\(arrayValue)"
            }
            return ("\(newIntValue)", arrayStringValue)
        case .clampedValue:
            return (String(format: "%.3f", newValue), String(format: "%.3f", clampValue(value: newValue)))
        case .linearlyInterpolatedValue:
            return (String(format: "%.3f", newValue), String(format: "%.3f", lerpValue(value: newValue)))
        case .randomGenerator, .randomArrayElement:
            return ("0.000", "0.000")
        }
    }

    private func clampValue(value: Float) -> Float {
        return Math.clamp(value, between: -2, and: 2)
    }
    
    fileprivate func lerpValue(value: Float) -> Float {
        return Math.lerp(from: 3, to: 7, t: CGFloat(value))
    }

    fileprivate func randomArrayElement() -> Int {
        return dummyArray.randomElement()
    }

    private func safeArrayValue(for index: Int) -> Int? {
        return dummyArray[safe: index]
    }

    private func generateRandomNumber() -> CGFloat {
        return Random.random()
    }

    private func updateNetworkActivityCount(count: Int) -> Int {
        let currentNetworkTasks = networkActivityController.taskCount

        if count > currentNetworkTasks {
            networkActivityController.startActivity()
        }
        else if count < currentNetworkTasks {
            networkActivityController.endActivity()
        }
        return networkActivityController.taskCount
    }
}

// MARK: Content specific rules

extension ContentCellViewModel {

    var description: String {
        switch type {
        case .randomGenerator:
            return "Click the button below to generate a random number between 0.0 and 1.0."
        case .networkActivityController:
            return "Move the slider below to simulate parallel network calls. Take notice of the actity indicator in the status bar."
        case .safeArray:
            return "Move the slider below to select the index of the element in array \(dummyArray.description)."
        case .randomArrayElement:
            return "Click the button below to select a random value from array \(dummyArray.description)."
        case .clampedValue:
            return "Move the slider below to clamp the value between -2 and 2."
        case .linearlyInterpolatedValue:
            return "Move the slider below to linearly interpolate between values 3 and 7."
        }
    }
    
    var firstSliderTitle: String {
        switch type {
        case .networkActivityController:
            return "Network activities:"
        case .safeArray:
            return "Selected index:"
        case .clampedValue, .linearlyInterpolatedValue:
            return "Slider value:"
        case .randomArrayElement, .randomGenerator:
            return ""
        }
    }
    
    var secondSliderTitle: String {
        switch type {
        case .safeArray:
            return "Array value:"
        case .clampedValue:
            return "Clamped value:"
        case .linearlyInterpolatedValue:
            return "Interpolated value:"
        case .randomGenerator, .randomArrayElement, .networkActivityController:
            return ""
        }
    }

    var exampleTitle: String {
        return "Example \(index)"
    }

    var actionButtonTitle: String {
        switch type {
        case .randomGenerator:
            return "Random.random()"
        case .randomArrayElement:
            return "array.randomElement()"
        case .safeArray, .networkActivityController, .linearlyInterpolatedValue, .clampedValue:
            return ""
        }
    }
    
    var sliderConfiguration: SliderConfiguration? {
        switch type {
        case .networkActivityController:
            let startingValue = Float(networkActivityController.taskCount)
            return SliderConfiguration(minimumValue: 0, maximumValue: 5, startingValue: startingValue)
        case .safeArray:
            return SliderConfiguration(minimumValue: 0, maximumValue: 10, startingValue: 0)
        case .clampedValue:
            return SliderConfiguration(minimumValue: -10, maximumValue: 10, startingValue: 0)
        case .linearlyInterpolatedValue:
            return SliderConfiguration(minimumValue: 0, maximumValue: 1, startingValue: 0)
        case .randomGenerator, .randomArrayElement:
            return nil
        }
    }

    var initialSliderResults: (String, String) {
        switch type {
        case .networkActivityController:
            return ("\(networkActivityController.taskCount)", "0.000")
        case .safeArray:
            return ("0", "\(randomArrayElement())")
        case .linearlyInterpolatedValue:
            return ("0.000", String(format: "%.3f", lerpValue(value: 0)))
        case .randomArrayElement, .randomGenerator, .clampedValue:
            return ("0.000", "0.000")
        }
    }

    var initialResult: String {
        switch type {
        case .randomArrayElement:
            return "\(dummyArray.randomElement())"
        case .randomGenerator, .clampedValue, .linearlyInterpolatedValue, .networkActivityController, .safeArray:
            return "0.000"
        }
    }
}

// MARK: Layout specific rules

extension ContentCellViewModel {

    func shouldDisplayActionButtonView() -> Bool {
        switch type {
        case .randomGenerator, .randomArrayElement:
            return true
        case .clampedValue, .linearlyInterpolatedValue, .networkActivityController, .safeArray:
            return false
        }
    }
    
    func shouldDisplaySliderView() -> Bool {
        switch type {
        case .networkActivityController, .safeArray, .clampedValue, .linearlyInterpolatedValue:
            return true
        case .randomGenerator, .randomArrayElement:
            return false
        }
    }
    
    func shouldDisplaySecondSliderResultView() -> Bool {
        switch type {
        case .safeArray, .clampedValue, .linearlyInterpolatedValue:
            return true
        case .randomGenerator, .randomArrayElement, .networkActivityController:
            return false
        }
    }
}
