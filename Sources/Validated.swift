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
 each new `Value` that is going to be set will get `validated` by the `Validation`.
 
 If the validation fails the `Value` will become `nil`.
 
 By using the `restore()` function you can restore the value to its last successful valiated value
 
 - Important:
 `@Validated` can only be applied to `Optional` types.
 
 # Usage:
 ```
 @Validated(.email)
 var email: String?
 ```
 */
@propertyWrapper
public struct Validated<Value: Optionalable> {
    
    // MARK: Properties
    
    /// The Validation
    let validation: Validation<Value.Wrapped>
    
    /// The validated Value
    var validatedValue: Value = nil {
        didSet {
            // Verify wrapped value is available for validated Value
            guard let wrapped = self.validatedValue.wrapped else {
                // Otherwise return out of function
                return
            }
            // Clear ValidationError
            self.validationError = nil
            // Initialize last successful validated value
            self.lastSuccessfulValidatedValue = .init(wrapped)
        }
    }
    
    /// Bool if the current value is valid
    public var isValid: Bool {
        return self.value.wrapped != nil
    }
    
    /// The current ValidationError
    public var validationError: ValidationError?
    
    /// The last successful validated Value
    var lastSuccessfulValidatedValue: Value?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter validation: The Validation
    public init(_ validation: Validation<Value.Wrapped>) {
        self.validation = validation
    }
    
    // MARK: Value
    
    /// The Value
    public var value: Value {
        set {
            // Switch on isValid
            switch self.isValid(value: newValue) {
            case .success(let value):
                // Set validated value
                self.validatedValue = value
            case .failure(let error):
                // Set ValidationError
                self.validationError = error
                // Clear validated value as Validation failed
                self.validatedValue = nil
            }
        }
        get {
            // Return validated value
            return self.validatedValue
        }
    }
    
}

// MARK: - Validatable

extension Validated: Validatable {
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Result if the validation succeeded or failed
    func isValid(value: Value) -> Result<Value, ValidationError> {
        // Verify wrapped value is available
        guard let wrappedValue = value.wrapped else {
            // Wrapped value is not available return false
            return .failure("Value is nil and can't be validated")
        }
        // Return value validation result
        return self.validation.isValid(value: wrappedValue).map { value }
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
            return .init(nilLiteral: ())
        }
        // Set validated value with last successful validated value
        self.validatedValue = lastSuccessfulValidatedValue
        // Return value
        return lastSuccessfulValidatedValue
    }
    
}
