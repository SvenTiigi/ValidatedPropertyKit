//
//  Validated.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validated

/**
 The `@Validated` PropertyWrapper to easily validate your properties 👮
 
 Based on the given `Validation` during the initialization of the `@Validated` PropertyWrapper
 each new `Value` that is going to be set will be `validated` by the `Validation`.
 If the validation fails the `Value` will become `nil`.
 
 # Important:
 `@Validated` can only be applied to `Optional` types.
 
 # Example:
 ```
 // Username will be nil if String is empty
 @Validated(.nonEmpty)
 var username: String?
 
 // AvatarURL will be nil if String isn't a valid URL and has a "https" prefix
 @Validated(.isURL && .hasPrefix("https"))
 var avatarURL: String?
 ```
 
 # Error Handling 🕵️‍♂️
 Beside doing a simple `nil` check on your `@Validated` property to ensure if the value is valid or not
 you can access the validatedValue or validationError property to retrieve the `ValidationError` or the valid value.
 
 ```
 @Validated(.nonEmpty)
 var username: String?
 
 // Switch on `validatedValue`
 switch $username.validatedValue {
 case .success(let value):
     // Value is valid ✅
     break
 case .failure(let validationError):
     // Value is invalid ⛔️
     break
 }
 
 // Or unwrap the `validationError`
 if let validationError = $username.validationError {
     // Value is invalid ⛔️
 } else {
     // Value is valid ✅
 }
 ```
 
 # Restore ↩️
 
 You can `restore` your `@Validated` property to the last successful validated value.
 
 ```
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
 
 # isValid ✅
 
 You can access the isValid Bool value property to check if the current value is valid.
 
 ```
 @Validated(.nonEmpty)
 var username: String?
 
 username = "Mr.Robot"
 print($username.isValid) // true
 
 username = ""
 print($username.isValid) // false
 ```
 
 # Validation Operators 🔗
 Validation Operators allowing you to combine multiple Validations like you would do with Bool values.
 
 ```
 // Logical AND
 @Validated(.isURL && .hasPrefix("https"))
 var avatarURL: String?
 
 // Logical OR
 @Validated(.hasPrefix("Mr.") || .hasPrefix("Mrs."))
 var name: String?
 
 // Logical NOT
 @Validated(!.contains("Android", options: .caseInsensitive))
 var favoriteOperatingSystem: String?
 ```
 */
@propertyWrapper
public struct Validated<Value: Optionalable> {
    
    // MARK: Properties
    
    /// The Validation
    let validation: Validation<Value.Wrapped>
    
    /// The validated value
    public private(set) var validatedValue: Result<Value.Wrapped, ValidationError> {
        didSet {
            // Switch on validated value
            switch self.validatedValue {
            case .success(let value):
                // If success store value to last successful validated value
                self.lastSuccessfulValidatedValue = value
            case .failure:
                // In failure case return
                return
            }
        }
    }
    
    /// Bool if the current value is valid
    public var isValid: Bool {
        return self.wrappedValue.wrapped != nil
    }
    
    /// The current ValidationError
    public var validationError: ValidationError? {
        // Switch on validated value
        switch self.validatedValue {
        case .success:
            // Return nil
            return nil
        case .failure(let error):
            // Return error
            return error
        }
    }
    
    /// The last successful validated Value
    var lastSuccessfulValidatedValue: Value.Wrapped?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter wrappedValue: The wrapped Value
    /// - Parameter validation: The Validation
    public init(
        wrappedValue: Value,
        _ validation: Validation<Value.Wrapped>
    ) {
        self.init(validation)
        self.wrappedValue = wrappedValue
    }
    
    /// Designated Initializer
    ///
    /// - Parameter validation: The Validation
    public init(_ validation: Validation<Value.Wrapped>) {
        self.validation = validation
        self.validatedValue = .failure(.nilError)
    }
    
    // MARK: Projected Value
    
    /// The projected Binding Value
    public var projectedValue: Result<Value.Wrapped, ValidationError> {
        return self.validatedValue
    }
    
    // MARK: Wrapped Value
    
    /// The Value
    public var wrappedValue: Value {
        set {
            // Set validated value by validating the new value
            self.validatedValue = self.isValid(value: newValue)
        }
        get {
            // Switch on validated value
            switch self.validatedValue {
            case .success(let value):
                // Return value
                return .init(value)
            case .failure:
                // Return nil
                return nil
            }
        }
    }
    
}

// MARK: - Validatable

extension Validated: Validatable {
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Result if the validation succeeded or failed
    public func isValid(value: Value) -> Result<Value.Wrapped, ValidationError> {
        // Verify wrapped value is available
        guard let wrappedValue = value.wrapped else {
            // Wrapped value is not available return failure with nil error
            return .failure(.nilError)
        }
        // Return value validation result
        return self.validation.isValid(value: wrappedValue).map { wrappedValue }
    }
    
}

// MARK: - Restore

public extension Validated {
    
    /// Restore to the last successful validated value if possible
    ///
    /// - Returns: The restored value if available
    @discardableResult
    mutating func restore() -> Value {
        // Verify last successful validated value is available
        guard let lastSuccessfulValidatedValue = self.lastSuccessfulValidatedValue else {
            // The last successful validated value is not available return nil
            return nil
        }
        // Set validated value with last successful validated value
        self.validatedValue = .success(lastSuccessfulValidatedValue)
        // Return value
        return .init(lastSuccessfulValidatedValue)
    }
    
}

// MARK: - ValidationError+nilError

private extension ValidationError {
    
    /// The `nil` ValidationError
    static let nilError: ValidationError = "Value is nil and can't be validated"
    
}
