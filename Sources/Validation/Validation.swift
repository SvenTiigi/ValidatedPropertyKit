//
//  Validation.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation

/// A Validation
public struct Validation<Value> {
    
    // MARK: Typealias
    
    /// The validation predicate typealias representing a `(Value) -> Bool` closure
    public typealias Predicate = (Value) -> Bool
    
    // MARK: Properties
    
    /// The Predicate
    private let predicate: Predicate
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameter predicate: The Predicate
    public init(predicate: @escaping Predicate) {
        self.predicate = predicate
    }
    
    /// Validates a value and returns a Bool wether the value is valid or not
    /// - Parameter value: The value that should be validates
    /// - Returns: Bool value if the value is valid or invalid
    func isValid(value: Value) -> Bool {
        self.predicate(value)
    }
    
}
