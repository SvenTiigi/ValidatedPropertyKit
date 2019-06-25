//
//  Validatable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 23.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validatable

/// The Validatable
public protocol Validatable {
    
    /// The generic Value
    associatedtype Value
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Bool if the given Value is valid or not
    func isValid(value: Value) -> Bool
    
}

// MARK: - AnyValidatable

/// The AnyValidatable Type-Erasure for the `Validatable` protocol
public struct AnyValidatable<Value>: Validatable {
    
    // MARK: Properties
    
    /// The isValid closure
    private let isValidClosure: (Value) -> Bool
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter validatable: The Validatable
    public init<V: Validatable>(_ validatable: V) where V.Value == Value {
        self.isValidClosure = validatable.isValid
    }
    
    /// Designated Initializer
    ///
    /// - Parameter validatable: The Validatable closure
    public init(_ validatableClosure: @escaping (Value) -> Bool) {
        self.isValidClosure = validatableClosure
    }
    
    // MARK: Validatable
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Bool if the given Value is valid or not
    public func isValid(value: Value) -> Bool {
        return self.isValidClosure(value)
    }
    
}
