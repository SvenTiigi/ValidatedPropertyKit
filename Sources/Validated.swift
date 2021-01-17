//
//  Validated.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Validated

/// A Validated PropertyWrapper
@propertyWrapper
public struct Validated<Value>: DynamicProperty, Validatable {
    
    // MARK: Properties
    
    /// The Storage
    @StateObject
    private var storage: Storage
    
    /// The Validation
    public var validation: Validation<Value> {
        self.storage.validation
    }
    
    /// Bool value if validated value is valid
    public var isValid: Bool {
        self.storage.isValid
    }
    
    // MARK: PropertyWrapper-Properties
    
    /// The projected `Binding<Value>`
    public var projectedValue: Binding<Value> {
        .init(
            get: {
                self.wrappedValue
            },
            set: { newValue in
                self.wrappedValue = newValue
            }
        )
    }
    
    /// The wrapped Value
    public var wrappedValue: Value {
        get {
            // Return value
            self.storage.value
        }
        nonmutating set {
            // Update value
            self.storage.value = newValue
        }
    }
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - wrappedValue: The wrapped `Value`
    ///   - validation: The `Validation`
    public init(
        wrappedValue: Value,
        _ validation: Validation<Value>
    ) {
        self._storage = .init(
            wrappedValue: .init(
                value: wrappedValue,
                validation: validation
            )
        )
    }
    
    // MARK: Update Validation
    
    /// Update the Validation
    /// - Parameters:
    ///   - reValidateValue: Bool value if current Value should be revalidated with new Validation. Default value `true`
    ///   - validation: The new Validation
    public mutating func update(
        reValidateValue: Bool = true,
        validation: (Validation<Value>) -> Validation<Value>
    ) {
        // Update Validation
        self.storage.validation = validation(self.validation)
        // Verify if value should be re-validated
        guard reValidateValue else {
            // Otherwise return out of function
            return
        }
        // Perform Validation
        self.storage.validate()
    }
    
}

// MARK: - Validated+Optionalable

public extension Validated where Value: Optionalable {
    
    /// Designated Initializer for an optional Value type
    /// - Parameters:
    ///   - wrappedValue: The wrapped `Value`. Default value `nil`
    ///   - validation: The `Validation` for the `Wrapped` value type
    ///   - nilValidation: The `Validation` if the Value  is nil. Default value `.constant(false)`
    init(
        wrappedValue: Value = nil,
        _ validation: Validation<Value.Wrapped>,
        nilValidation: Validation<Void> = .constant(false)
    ) {
        self.init(
            wrappedValue: wrappedValue,
            .init { value in
                value.wrapped.flatMap(validation.isValid)
                    ?? nilValidation.isValid(value: ())
            }
        )
    }
    
}

// MARK: - Storage

private extension Validated {
    
    /// The Storage
    final class Storage: ObservableObject {
        
        // MARK: Properties
        
        /// The Value
        var value: Value {
            willSet {
                // Emit on ObjectWillChange Subject
                self.objectWillChange.send()
            }
            didSet {
                // Perform Validation
                self.validate()
            }
        }
        
        /// The Validation
        var validation: Validation<Value>
        
        /// Bool value if validated value is valid
        var isValid: Bool
        
        // MARK: Initializer
        
        /// Designated Initializer
        /// - Parameters:
        ///   - value: The Value
        ///   - validation: The Validation
        init(
            value: Value,
            validation: Validation<Value>
        ) {
            self.value = value
            self.validation = validation
            self.isValid = self.validation.isValid(value: self.value)
        }
        
        // MARK: Validate
        
        /// Perform Validation
        func validate() {
            // Validate value
            self.isValid = self.validation.isValid(value: self.value)
        }
        
    }
    
}
