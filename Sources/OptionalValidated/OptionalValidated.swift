//
//  OptionalValidated.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 22.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Combine
import Foundation

// MARK: - OptionalValidated

/// An OptionalValidated PropertyWraper
@propertyWrapper
public struct OptionalValidated<Value: Optionalable> {
    
    // MARK: Properties
    
    /// The Validated Value
    private var validatedValue: Validated<Value>
    
    /// Bool value if validated value is valid
    public var isValid: Bool {
        self.validatedValue.isValid
    }
    
    /// The Validation Changed Publisher
    public var validationChanged: AnyPublisher<Bool, Never> {
        self.validatedValue.validationChanged
    }
    
    // MARK: PropertyWrapper-Properties
    
    /// The projected `isValid` Bool value
    public var projectedValue: Bool {
        self.validatedValue.isValid
    }
    
    /// The wrapped Value
    public var wrappedValue: Value {
        get {
            self.validatedValue.wrappedValue
        }
        set {
            self.validatedValue.wrappedValue = newValue
        }
    }
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - wrappedValue: The Value. Default value `nil`
    ///   - validation: The Validation
    ///   - isValidIfNil: Bool value if `isValid` if `Value` is nil. Default value `false`
    public init(
        wrappedValue: Value = nil,
        _ validation: Validation<Value.Wrapped>,
        isValidIfNil: Bool = false
    ) {
        self.validatedValue = .init(
            wrappedValue: wrappedValue,
            .init { value in
                value.wrapped.flatMap(validation.isValid) ?? isValidIfNil
            }
        )
    }
    
    // MARK: Update Validation
    
    /// Update the Validation
    /// - Parameters:
    ///   - validation: The new Validation
    ///   - reValidateValue: Bool value if current Value should be revalidated with new Validation. Default value `true`
    ///   - isValidIfNil: Bool value if `isValid` if `Value` is nil. Default value `false`
    public mutating func update(
        validation: Validation<Value.Wrapped>,
        reValidateValue: Bool = true,
        isValidIfNil: Bool = false
    ) {
        self.validatedValue.update(
            validation: .init { value in
                value.wrapped.flatMap(validation.isValid) ?? isValidIfNil
            },
            reValidateValue: reValidateValue
        )
    }
    
}
