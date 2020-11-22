//
//  Validation+Comparable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Comparable

public extension Validation where Value: Comparable {
    
    /// Validation with less `<` than comparable value
    ///
    /// - Parameter comparableValue: The Comparable value
    /// - Returns: The Validation
    static func less(
        _ comparableValue: Value
    ) -> Self {
        .init { value in
            value < comparableValue
        }
    }
    
    /// Validation with less or equal `<=` than comparable value
    ///
    /// - Parameter comparableValue: The Comparable value
    /// - Returns: The Validation
    static func lessOrEqual(
        _ comparableValue: Value
    ) -> Self {
        .init { value in
            value <= comparableValue
        }
    }
    
    /// Validation with greater `>` than comparable value
    ///
    /// - Parameter comparableValue: The Comparable value
    /// - Returns: The Validation
    static func greater(
        _ comparableValue: Value
    ) -> Self {
        .init { value in
            value > comparableValue
        }
    }
    
    /// Validation with greater or equal `>=` than comparable value
    ///
    /// - Parameter comparableValue: The Comparable value
    /// - Returns: The Validation
    static func greaterOrEqual(
        _ comparableValue: Value
    ) -> Self {
        .init { value in
            value >= comparableValue
        }
    }
    
}
