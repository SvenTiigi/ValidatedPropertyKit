//
//  Validation+ComparisonOperators.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Equal

public extension Validation {
    
    /// Returns a Validation where two given Validation results will be compared to equality
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Self {
        .init { value in
            lhs.isValid(value: value) == rhs.isValid(value: value)
        }
    }
    
}

// MARK: - Validation+Unequal

public extension Validation {
    
    /// Returns a Validation where two given Validation results will be compared to unequality
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    static func != (
        lhs: Self,
        rhs: Self
    ) -> Self {
        .init { value in
            lhs.isValid(value: value) != rhs.isValid(value: value)
        }
    }
    
}
