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
 The `@Validated` PropertyWrapper
 
 Based on the given `Validation` during the initialization of the `@Validated` PropertyWrapper
 each new `Value` that is going to be set will be `validated` by the `Validation`.
 
 If the validation fails the `Value` will become `nil`.
 
 By using the `restore()` function you can restore the value to its last successful valiated value
 
 - Important:
 `@Validated` can only be applied to `Optional` types.
 
 # Example:
 ```
 // Username will be nil if String is empty
 @Validated(.nonEmpty)
 var username: String?
 
 // Email will be nil if String isn't a valid E-Mail address
 @Validated(.isEmail)
 var email: String?
 
 // Password will be nil if String is less than 8 characters
 @Validated(.range(8...))
 var password: String?
 
 // Friends will be nil if Int is less than 1
 @Validated(.greaterOrEqual(1))
 var friends: Int?
 
 // AvatarURL will be nil if String isn't a valid URL and hasn't a "https" prefix
 @Validated(.isURL && .hasPrefix("https"))
 var avatarURL: String?
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
    /// - Parameter validation: The Validation
    public init(_ validation: Validation<Value.Wrapped>) {
        self.validation = validation
        self.validatedValue = .failure(.nilError)
    }
    
    /// Designated Initializer
    ///
    /// - Parameter initialValue: The initial Value
    /// - Parameter validation: The Validation
    public init(initialValue: Value,
                _ validation: Validation<Value.Wrapped>) {
        self.init(validation)
        self.wrappedValue = initialValue
    }
    
    // MARK: Value
    
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
    func isValid(value: Value) -> Result<Value.Wrapped, ValidationError> {
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
