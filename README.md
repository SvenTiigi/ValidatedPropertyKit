<p align="center">
   <img width="750" src="https://raw.githubusercontent.com/SvenTiigi/ValidatedPropertyKit/gh-pages/readMeAssets/ValidatedPropertyKit.gif?token=ACZQQFSSRPFFJDC6NTL6JEC5DODWY" alt="ValidatedPropertyKit Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat" alt="Swift 5.1">
   </a>
   <a href="http://cocoapods.org/pods/ValidatedPropertyKit">
      <img src="https://img.shields.io/cocoapods/v/ValidatedPropertyKit.svg?style=flat" alt="Version">
   </a>
   <a href="http://cocoapods.org/pods/ValidatedPropertyKit">
      <img src="https://img.shields.io/cocoapods/p/ValidatedPropertyKit.svg?style=flat" alt="Platform">
   </a>
   <br/>
   <a href="https://github.com/Carthage/Carthage">
      <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
   <a href="https://sventiigi.github.io/ValidatedPropertyKit">
      <img src="https://github.com/SvenTiigi/ValidatedPropertyKit/blob/gh-pages/badge.svg" alt="Documentation">
   </a>
   <a href="https://twitter.com/SvenTiigi/">
      <img src="https://img.shields.io/badge/Twitter-@SvenTiigi-blue.svg?style=flat" alt="Twitter">
   </a>
</p>

<br/>

<p align="center">
   ValidatedPropertyKit enables you to easily validate your properties<br/>with the power of <a href="https://github.com/DougGregor/swift-evolution/blob/property-wrappers/proposals/0258-property-wrappers.md">Property Wrappers</a>.
</p>

<br/>

```swift
struct User {
    
    @Validated(.nonEmpty)
    var username: String?
    
    @Validated(.isEmail)
    var email: String?
    
    @Validated(.range(8...))
    var password: String?
    
    @Validated(.greaterOrEqual(13))
    var age: Int?
    
    @Validated(.isURL && .hasSuffix("jpg"))
    var avatarURL: String?
    
    @Validated(!.contains("Android", options: .caseInsensitive))
    var favoriteOperatingSystem: String?
    
    @Validated(.init { $0.first == "+" })
    var phoneNumber: String?
    
}
```

## Features

- [x] Easily validate your properties 👮
- [x] Predefined validations 🚦
- [x] Logical Operators to combine validations 🔗
- [x] Customization and configuration to your needs 💪

## Installation

> ⚠️ ValidatedPropertyKit can currently only be used with Xcode 11 Beta and Swift 5.1.

### CocoaPods

ValidatedPropertyKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```bash
pod 'ValidatedPropertyKit'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate ValidatedPropertyKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "SvenTiigi/ValidatedPropertyKit"
```

Run `carthage update` to build the framework and drag the built `ValidatedPropertyKit.framework` into your Xcode project. 

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SvenTiigi/ValidatedPropertyKit.git", from: "1.0.0")
]
```

Or navigate to your Xcode project then select `Swift Packages`, click the “+” icon and search for `ValidatedPropertyKit`.

<p align="center">
<img width="80%" src="https://raw.githubusercontent.com/SvenTiigi/ValidatedPropertyKit/gh-pages/readMeAssets/XcodeSPM.png?token=ACZQQFUTD2N73S3AOCV666C5DODYM" alt="Xcode SPM">
</p>

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate ValidatedPropertyKit into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

### Validated 👮‍♂️

The `@Validated` attribute allows you to specify a validation along to the declaration of your property.

It is important to say that the `@Validated` attribute can only be applied to mutable [`Optional`](https://developer.apple.com/documentation/swift/optional) types as a validation can either succeed or fail.

```swift
@Validated(.nonEmpty)
var username: String?

username = "Mr.Robot"
print(username) // "Mr.Robot"

username = ""
print(username) // nil
```

### Validation 🚦

Every `@Validated` attribute must be initialized with a `Validation` which simply takes a `(Value) -> Bool` closure.

```swift
@Validated(.init { value in
    value.first == "+"
})
var phoneNumber: String?
```
> ☝️ Check out the [Predefined Validations](https://github.com/SvenTiigi/ValidatedPropertyKit#predefined-validations) section to get an overview of the many predefined validations.

Additionally, you can extend the `Validation` struct via `conditional conformance` to easily declare your own `Validations`.

```swift
extension Validation where Value == Int {

    /// Will validate if the Integer is the meaning of life
    static var isMeaningOfLife: Validation {
        return .init { value in
            return value == 42
        }
    }

}
```

And apply them to your validated property.

```swift
@Validated(.isMeaningOfLife)
var number: Int?
```

### Restore ↩️

Each property that is declared with the `@Validated` attribute can make use of the `restore()` function from the `Validated` Property Wrapper itself via the `$` notation prefix.

When invoking `$property.restore()` the value will get restored to the last successful validated value.

```swift
@Validated(.nonEmpty)
var username: String?

username = "Mr.Robot"
print(username) // "Mr.Robot"

username = ""
print(username) // nil

// Restore to last successful validated value
$username.restore()
print(username) // "Mr.Robot"
```

### isValid ✅

As the aforementioned `restore()` function you can also access the `isValid` Bool value property to check if the current value is valid.

```swift
@Validated(.nonEmpty)
var username: String?

username = "Mr.Robot"
print($username.isValid) // true

username = ""
print($username.isValid) // false
```

### Validation Operators 🔗

Validation Operators allowing you to combine multiple Validations like you would do with Bool values.

```swift
// Logical AND
@Validated(.isURL && .hasSuffix("jpg"))
var avatarURL: String?

// Logical OR
@Validated(.hasPrefix("Mr.") || .hasPrefix("Mrs."))
var name: String?

// Logical NOT
@Validated(!.contains("Android", options: .caseInsensitive))
var favoriteOperatingSystem: String?
```

### Predefined Validations

The `ValidatedPropertyKit` comes with many predefined common validations which you can make use of in order to specify a `Validation` for your validated property.

**KeyPath**

The `keyPath` validation will allow you to specify a validation for a given `KeyPath` of the attributed property.

```swift
@Validated(.keyPath(\.isEnabled, .equals(true)))
var button: UIButton?
```

**Strings**

A String property can be validated in many ways like `contains`, `hasPrefix` and even `RegularExpressions`. 

```swift
@Validated(.contains("Mr.Robot"))
var string: String?

@Validated(.hasPrefix("Mr."))
var string: String?

@Validated(.hasSuffix("OS"))
var string: String?

@Validated(.regularExpression("[0-9]+$"))
var string: String?

@Validated(.isLowercased)
var string: String?

@Validated(.isUppercased)
var string: String?

@Validated(.isEmail)
var string: String?

@Validated(.isURL)
var string: String?

@Validated(.isNumeric)
var string: String?
```

**Equatable**

A `Equatable` type can be validated against a specified value. 

```swift
@Validated(.equals(42))
var number: Int?
```

**Sequence**

A property of type `Sequence` can be validated via the `contains` or `startsWith` validation.

```swift
@Validated(.contains("Mr.Robot", "Elliot"))
var sequence: [String]?

@Validated(.startsWith("First Entry"))
var sequence: [String]?
```

**Collection**

Every `Collection` type offers the `nonEmpty` validation and the `range` validation where you can easily declare the valid capacity.

```swift
@Validated(.nonEmpty)
var collection: [String]?

@Validated(.range(1...10))
var collection: [String]?
```

**Comparable**

A `Comparable` type can be validated with all common comparable operators.

```swift
@Validated(.less(50))
var comparable: Int?

@Validated(.lessOrEqual(50))
var comparable: Int?

@Validated(.greater(50))
var comparable: Int?

@Validated(.greaterOrEqual(50))
var comparable: Int?
```


## Contributing
Contributions are very welcome 🙌

## License

```
ValidatedPropertyKit
Copyright (c) 2019 Sven Tiigi sven.tiigi@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
