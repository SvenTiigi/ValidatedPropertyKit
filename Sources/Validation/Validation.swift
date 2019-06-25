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
    
    /// The Predicate Typealias representing `(Value) -> Bool`
    public typealias Predicate = (Value) -> Bool
    
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
    /// - Returns: A Bool if the given Value is valid or not
    public func isValid(value: Value) -> Bool {
        return self.predicate(value)
    }
    
}
