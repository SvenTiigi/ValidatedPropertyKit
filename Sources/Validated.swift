//
//  Validated.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Combine
import Foundation

// MARK: - Validated

/// A Validated PropertyWrapper
@propertyWrapper
public struct Validated<Value> {
    
    // MARK: Properties
    
    /// The Value
    private var value: Value
    
    /// The Validation
    private var validation: Validation<Value>
    
    /// Bool value if validated value is valid
    public private(set) var isValid: Bool {
        didSet {
            // Verify validation state has changed
            guard self.isValid != oldValue else {
                // Otherwise return out of function
                return
            }
            // Send updated validation state
            self.validationSubject.send(self.isValid)
        }
    }
    
    /// The Validation Subject
    private let validationSubject = PassthroughSubject<Bool, Never>()
    
    /// The Validation Changed Publisher
    public var validationChanged: AnyPublisher<Bool, Never> {
        self.validationSubject.eraseToAnyPublisher()
    }
    
    // MARK: PropertyWrapper-Properties
    
    /// The projected `isValid` Bool value
    public var projectedValue: Bool {
        self.isValid
    }
    
    /// The wrapped Value
    public var wrappedValue: Value {
        get {
            // Return stored value
            self.value
        }
        set {
            // Update value
            self.value = newValue
            // Validate new value
            self.isValid = self.validation.isValid(value: self.value)
        }
    }
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - wrappedValue: The wrapped value
    ///   - validation: The Validation
    public init(
        wrappedValue: Value,
        _ validation: Validation<Value>
    ) {
        self.value = wrappedValue
        self.validation = validation
        self.isValid = self.validation.isValid(value: self.value)
        self.validationSubject.send(self.isValid)
    }
    
    // MARK: Update Validation
    
    /// Update the Validation
    /// - Parameters:
    ///   - validation: The new Validation
    ///   - reValidateValue: Bool value if current Value should be revalidated with new Validation. Default value `true`
    public mutating func update(
        validation: Validation<Value>,
        reValidateValue: Bool = true
    ) {
        self.validation = validation
        guard reValidateValue else {
            return
        }
        self.wrappedValue = self.value
    }
    
}
