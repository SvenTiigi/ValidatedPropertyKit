<p align="center">
   <img width="750" src="https://raw.githubusercontent.com/SvenTiigi/ValidatedPropertyKit/gh-pages/readMeAssets/ValidatedPropertyKit.gif" alt="ValidatedPropertyKit Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat" alt="Swift 5.1">
   </a>
   <a href="https://github.com/SvenTiigi/ValidatedPropertyKit/actions?query=workflow%3ACI">
      <img src="https://github.com/SvenTiigi/ValidatedPropertyKit/workflows/CI/badge.svg" alt="CI Status">
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
struct LoginView: View {
    
    @Validated(!.isEmpty && .isEmail)
    var mailAddress = String()
    
    @Validated(.range(8...))
    var password = String()
    
    var body: some View {
        List {
            TextField("E-Mail", text: self.$mailAddress)
            TextField("Password", text: self.$password)
            Button(
                action: {
                    print("Login", self.mailAddress, self.password)
                },
                label: {
                    Text("Submit")
                }
            )
            .validated(
                self._mailAddress,
                self._password
            )
        }
    }
    
}
```

## Features

- [x] Easily validate your properties 👮
- [x] Predefined validations 🚦
- [x] Logical Operators to combine validations 🔗
- [x] Customization and configuration to your needs 💪

## Installation

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
    .package(url: "https://github.com/SvenTiigi/ValidatedPropertyKit.git", from: "0.0.5")
]
```

Or navigate to your Xcode project then select `Swift Packages`, click the “+” icon and search for `ValidatedPropertyKit`.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate ValidatedPropertyKit into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Validated 👮‍♂️

The `@Validated` attribute allows you to specify a validation alongside to the declaration of your property.

> ☝️ @Validated supports SwiftUI View updates and will basically work the same way as @State does.

```swift
@Validated(!.isEmpty)
var username = String()

@Validated(.hasPrefix("https"))
var avatarURL: String?
```

If `@Validated` is applied on an optional type e.g. `String?` you can specify whether the validation should fail or succeed when the value is `nil`.

```swift
@Validated(
   .isURL && .hasPrefix("https"), 
   nilValidation: .constant(false)
)
var avatarURL: String?
```

> By default the argument `nilValidation` is set to `.constant(false)`

In addition the `SwiftUI.View` extension `validated()` allows you to disable or enable a certain `SwiftUI.View` based on your `@Validated` properties. The `validated()` function will disable the `SwiftUI.View` if at least one of the passed in `@Validated` properties evaluates to `false`.

```swift
@Validated(!.isEmpty && .contains("@"))
var mailAddress = String()
    
@Validated(.range(8...))
var password = String()

Button(
   action: {},
   label: { Text("Submit") }
)
.validated(self._mailAddress && self._password)
```

> By using the underscore notation you are passing the `@Validated` property wrapper to the `validated()` function

## Validation 🚦

Each `@Validated` attribute will be initialized with a `Validation` which can be initialized with a simple closure that must return a `Bool` value.

```swift
@Validated(.init { value in
   value.isEmpty
})
var username = String()
```

Therefore, ValidatedPropertyKit comes along with many built-in convenience functions for various types and protocols.

```swift
@Validated(!.contains("Android", options: .caseInsensitive))
var favoriteOperatingSystem = String()

@Validated(.equals(42))
var magicNumber = Int()

@Validated(.keyPath(\.isEnabled, .equals(true)))
var object = MyCustomObject()
```
> Head over the [Predefined Validations](https://github.com/SvenTiigi/ValidatedPropertyKit#predefined-validations) section to learn more

Additionally, you can extend the `Validation` via conditional conformance to easily declare your own Validations.

```swift
extension Validation where Value == Int {

    /// Will validate if the Integer is the meaning of life
    static var isMeaningOfLife: Self {
        .init { value in
            value == 42
        }
    }

}
```

And apply them to your validated property.

```swift
@Validated(.isMeaningOfLife)
var number = Int()
```

## isValid ✅

You can access the `isValid` state at anytime by using the underscore notation to directly access the `@Validated` property wrapper.

```swift
@Validated(!.isEmpty)
var username = String()

username = "Mr.Robot"
print(_username.isValid) // true

username = ""
print(_username.isValid) // false
```

## Validation Operators 🔗

Validation Operators allowing you to combine multiple Validations like you would do with Bool values.

```swift
// Logical AND
@Validated(.hasPrefix("https") && .hasSuffix("png"))
var avatarURL = String()

// Logical OR
@Validated(.hasPrefix("Mr.") || .hasPrefix("Mrs."))
var name = String()

// Logical NOT
@Validated(!.contains("Android", options: .caseInsensitive))
var favoriteOperatingSystem = String()
```

## Predefined Validations

The `ValidatedPropertyKit` comes with many predefined common validations which you can make use of in order to specify a `Validation` for your validated property.

**KeyPath**

The `keyPath` validation will allow you to specify a validation for a given `KeyPath` of the attributed property.

```swift
@Validated(.keyPath(\.isEnabled, .equals(true)))
var object = MyCustomObject()
```

**Strings**

A String property can be validated in many ways like `contains`, `hasPrefix` and even `RegularExpressions`. 

```swift
@Validated(.isEmail)
var string = String()

@Validated(.contains("Mr.Robot"))
var string = String()

@Validated(.hasPrefix("Mr."))
var string = String()

@Validated(.hasSuffix("OS"))
var string = String()

@Validated(.regularExpression("[0-9]+$"))
var string = String()
```

**Equatable**

A `Equatable` type can be validated against a specified value. 

```swift
@Validated(.equals(42))
var number = Int()
```

**Sequence**

A property of type `Sequence` can be validated via the `contains` or `startsWith` validation.

```swift
@Validated(.contains("Mr.Robot", "Elliot"))
var sequence = [String]()

@Validated(.startsWith("First Entry"))
var sequence = [String]()
```

**Collection**

Every `Collection` type offers the `isEmpty` validation and the `range` validation where you can easily declare the valid capacity.

```swift
@Validated(!.isEmpty)
var collection = [String]()

@Validated(.range(1...10))
var collection = [String]()
```

**Comparable**

A `Comparable` type can be validated with all common comparable operators.

```swift
@Validated(.less(50))
var comparable = Int()

@Validated(.lessOrEqual(50))
var comparable = Int()

@Validated(.greater(50))
var comparable = Int()

@Validated(.greaterOrEqual(50))
var comparable = Int()
```

## Featured on

* [iOS Goodies](https://ios-goodies.com/post/185888580686/week-288)
* [iOS Dev Weekly](https://iosdevweekly.com/issues/410#start)
* [Swift Weekly](http://digest.swiftweekly.com/issues/swift-weekly-issue-163-186066)
* [AppCoda Weekly](http://digest.appcoda.com/issues/appcoda-weekly-issue-130-186576)
* [AwesomeiOS Weekly](http://weekly.awesomeios.com/issues/27)

## Contributing
Contributions are very welcome 🙌

## License

```
ValidatedPropertyKit
Copyright (c) 2021 Sven Tiigi sven.tiigi@gmail.com

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
