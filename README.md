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
final class ViewModel {
    
    @Validated(!.isEmpty)
    var username = String()
    
    @Validated(.isEmail)
    var email = String()
    
    @Validated(.range(8...))
    var password = String()
    
    @Validated(.greaterOrEqual(1))
    var friends = Int()
    
    @OptionalValidated(.isURL && .hasPrefix("https"))
    var avatarURL: String?
    
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

## Usage

### Validated 👮‍♂️

The `@Validated` attribute allows you to specify a validation along to the declaration of your property.

Use the `@OptionalValidated` property wrapper if you want to validate `Optional` properties.

```swift
@Validated(!.isEmpty)
var username = String()

@OptionalValidated(.isURL && .hasPrefix("https"))
var avatarURL: String?
```

Additionally, the `@OptionalValidated` property wrapper allows you to specify if the validation should fail or succeed when the value is `nil`.

```swift
@OptionalValidated(
   .isURL && .hasPrefix("https"), 
   isValidIfNil: false
)
var avatarURL: String?
```

> By default the argument `isValidIfNil` is set to `false`

### Validation 🚦

Use the projected value of a `@Validated` or `@OptionalValidated` property wrapper to access the result of the validation.

The projected value of the `Validated` property wrapper can be accessed via the (`$`) notation.

```swift
@Validated(!.isEmpty)
var username = String()

username = "Mr.Robot"
print($username) // true

username = ""
print($username) // false
```

Or you can make use of the `validationChanged` Publisher which will emit whenever the validation result changes.

Therefore you need to access the property wrapper directly via the (`_`) notation.

```swift
@Validated(!.isEmpty)
var username = String()

let cancellable = _username
   .validationChanged
   .sink { isValid in
      print(isValid)
   }
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
Copyright (c) 2020 Sven Tiigi sven.tiigi@gmail.com

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
