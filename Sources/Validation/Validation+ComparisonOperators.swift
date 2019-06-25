//
//  Validation+ComparisonOperators.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Equal

public extension Validation {
    
    /// Returns a Validation where two given Validation results will be compared to equality
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    /// - Returns: The new Validation
    static func == (lhs: Validation, rhs: Validation) -> Validation {
        return .init { value in
            return lhs.isValid(value: value) == rhs.isValid(value: value)
        }
    }
    
}

// MARK: - Validation+Unequal

public extension Validation {
    
    /// Returns a Validation where two given Validation results will be compared to unequality
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    /// - Returns: The new Validation
    static func != (lhs: Validation, rhs: Validation) -> Validation {
        return .init { value in
            return lhs.isValid(value: value) != rhs.isValid(value: value)
        }
    }
    
}
