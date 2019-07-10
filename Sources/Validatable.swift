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
    
    /// The Value type
    associatedtype Value
    
    /// The Success type
    associatedtype Success
    
    /// The Failure type
    associatedtype Failure: Error
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Result if the validation succeeded or failed
    func isValid(value: Value) -> Result<Success, Failure>
    
}
