//
//  Validatable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 23.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validatable

/// THe Validatable
protocol Validatable {
    
    /// The Value
    associatedtype Value
    
    /// The Success value
    associatedtype Success
    
    /// Validate the Value
    ///
    /// - Parameter value: The Value that should be validated
    /// - Returns: A Result if the validation succeeded or failed
    func isValid(value: Value) -> Result<Success, ValidationError>
    
}
