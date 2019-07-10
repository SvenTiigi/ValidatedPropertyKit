//
//  Validation.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation

/// The Validation
public struct Validation<Value> {
    
    // MARK: Properties
    
    /// The Predicate Typealias representing `(Value) -> Result<Void, ValidationError>`
    public typealias Predicate = (Value) -> Result<Void, ValidationError>
    
    /// The Predicate
    let predicate: Predicate
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter predicate: The Predicate `(Value) -> Bool`
    public init(predicate: @escaping Predicate) {
        self.predicate = predicate
    }
    
}

// MARK: - Validatable

extension Validation: Validatable {
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Result if the validation succeeded or failed
    public func isValid(value: Value) -> Result<Void, ValidationError> {
        return self.predicate(value)
    }
    
}
