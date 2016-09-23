# FiveUtils

[![CI Status](http://img.shields.io/travis/fiveagency/ios-five-utils.svg?style=flat)](https://travis-ci.org/fiveagency/ios-five-utils)
[![Version](https://img.shields.io/cocoapods/v/FiveUtils.svg?style=flat)](http://cocoapods.org/pods/FiveUtils)
[![License](https://img.shields.io/cocoapods/l/FiveUtils.svg?style=flat)](http://cocoapods.org/pods/FiveUtils)
[![Platform](https://img.shields.io/cocoapods/p/FiveUtils.svg?style=flat)](http://cocoapods.org/pods/FiveUtils)

## About

This bundle contains Swift utility functions we tend to re-use on many of our projects (us being [Five Agency's](http://five.agency) iOS Team). We expect there'll be many more added, but in the mean time, you're free to use/re-use/upgrade all of the existing code here. Everything and anything regarding helper functions, random generators, math, and other nice to have snippets.

## Requirements

* Xcode 8.0
* Swift 3.0

* iOS 8.0+

## Installation

There are no additional dependencies.

Currently supported installation options:

### Using [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

To install it, simply add the following line to your Podfile:

```
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'FiveUtils'
end

```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```
$ pod install
```

**:warning: If you want to use CocoaPods with Xcode 8.0 and Swift 3.0, you might need to add the following
lines to your podfile: :warning:**

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
```

### Manually using git submodules

* Add FiveUtils as a submodule

```
$ git submodule add https://github.com/fiveagency/ios-five-utils.git
```

* Drag `FiveUtils.xcodeproj` into Project Navigator.

* Go to `Project > Targets > Build Phases > Link Binary With Libraries`, click `+` and select `FiveUtils.framework` target.

## Examples

To run the example project do the following.

* Clone the repo by typing:
```
$ git clone https://github.com/fiveagency/ios-five-utils.git YOUR_DESTINATION_FOLDER
```

* Open `FiveUtils.xcworkspace`, choose `Example` scheme and hit `run`. This method will build everything and run the sample app.

## Usage

### **Math** module

    /**
     Clamps value between lower and upper bound.
     */
`public static func clamp<T: Comparable>(_ value: T, between lower: T, and upper: T) -> T`

Example usage:

```
print(clamp(32, lower: 1, upper: 3))
print(clamp(14, lower: 10, upper: 20))
print(clamp(1, lower: 5, upper: 7))
```

results in

```
> 3
> 14
> 5
```

    /**
     Interpolates linearly between initial and target value.
     */
`public static func lerp<T: Lerpable>(from first: T, to second: T, t: CGFloat) -> T`

*Note:* Currently supported *lerpable* types are `CGFloat`, `Double`, `Float` and `Int`.

Example usage:

```
print(lerp(from: 4, to: 8, t: 0.5))
print(lerp(from: 1.0, to: 5.0, t: 1.0))
```

results in

```
> 6
> 5.0
```

### **Random** module
    /**
     Returns a random CGFloat value specified in the [from, to) set. If no values get specified,
     the default set is [0.0, 1.0). The method allows for set bounds to be inverted meaning
     upper set bound may be set to smaller number than lower bound.
     */
`public static func random(_ from: CGFloat = 0, to: CGFloat = 1.0) -> CGFloat`

Example usage:

```
print(random())
print(random(3.0, to: 4.5))
print(random(2.0, to: 0.0))
```

can result in

```
> ~0.76
> ~3.78
> ~1.15
```

Similarly, there are other random generators in this module:

`public static func from(_ range: Range<Int>) -> Int`

`public static func from(_ from: Int, to: Int) -> Int`

`public static func alphanumericCharacter() -> Character`

`public static func alphanumericString(withLength length: Int) -> String`

### **TimeInterval** module

    /**
     Creates an FiveTimeInterval object by summing up amounts of different time units.
     */
`public init(weeks: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Double = 0)`

Example usage:

```
let timeInterval = TimeInterval(weeks: 0, days: 0, hours: 0, minutes: 2)
print(timeInterval.totalSeconds)
print(timeInterval.totalMinutes)
```

results in

```
> 120
> 2
```

### **FiveNetworkController** module

    /**
     Wrapper around UIApplication network activity indicator.
     It ensures that activity indicator cannot be hidden if there is some active task that
     requires its presence. Also, when all tasks are done, it automatically hides network
     activity indicator.
    */

Example usage:

```
let networkActivityController = FiveNetworkActivityController.shared

//   Start two network tasks (usually called by some outer handler module)
// and display the network activity indicator.
networkActivityController.startActivity()
networkActivityController.startActivity()

networkActivityController.endActivity() // Here, the network activity indicator is still displayed.
networkActivityController.endActivity() // Finally, hide the activity indicator.
```

### **Array+Five** module

    /*
     Allows for returning of 'nil' values in case a specified index is out of bounds.
     */
`public subscript(safe index: Int) -> Element?`

Example usage:

```
let dummyArray = [1, 2, 3, 4, 5]
print(dummyArray[safe: 1])
print(dummyArray[safe: 13])
```

results in

```
> 2
> nil
```

    /**
     Returns a random element.
     */    
`public func randomElement() -> Element`

Example usage:

```
let dummyArray = [1, 2, 3, 4, 5]
print(dummyArray.randomElement())
```

can result in

```
> 4
```

The following two are related to archiving an array via NSKeyedArchiver/Unarchiver.

    /**
     Archives the array into user defaults.
     */
`public func archive(_ key: String)`
    
    /**
     Tries to unarchive the array. If unsuccessfull, returns nil.
     */    
`public static func unarchive(_ key: String) -> Array?`

Example usage:

```
let key = "archiveKey"
let dummyArray = [1, 2, 3, 4, 5]

dummyArray.archive(key)
guard let unarchivedArray = Array<Int>.unarchive(key) else {
    assertionFailure("This should not happen.")
}
print(unarchivedArray == dummyArray)
```

results in

```
> true
```

### **Int+Five** module

    /**
     Returns a string that represents this integer as an ordinal number, e.g. "1st" for 1, "2nd" for 2 etc.
    */
`public var ordinalString: String`

Example usage:

```
print(1.ordinalString)
print(2.ordinalString)
print(3.ordinalString)
print(4.ordinalString)
print(92.ordinalString)
```

results in

```
> 1st
> 2nd
> 3rd
> 4th
> 92nd
```

## Authors

**Five Utils library team (listed alphabetically)**

* Denis Mendica

* Kristijan Rožanković

* Miran Brajsa

* Niko Mikuličić

## License

FiveUtils is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
