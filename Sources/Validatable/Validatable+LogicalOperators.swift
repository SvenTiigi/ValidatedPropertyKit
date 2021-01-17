//
//  Validatable+LogicalOperators.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 05.01.21.
//  Copyright © 2021 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - DefaultValidatable

/// The DefaultValidatable
private struct DefaultValidatable: Validatable {
    
    /// Bool value if is valid
    let isValid: Bool
    
}

// MARK: - Validatable+Not

public extension Validatable {
    
    /// Performs a logical `NOT` (`!`) operation on a Validatable
    /// - Parameter validatable: The Validatable value to negate
    static prefix func ! (
        validatable: Self
    ) -> Validatable {
        DefaultValidatable(
            isValid: !validatable.isValid
        )
    }
    
}

// MARK: - Validatable+And

public extension Validatable {
    
    /// Performs a logical `AND` (`&&`) operation on two Validatables
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    static func && (
        lhs: Self,
        rhs: @autoclosure @escaping () -> Self
    ) -> Validatable {
        DefaultValidatable(
            isValid: lhs.isValid && rhs().isValid
        )
    }
    
}

// MARK: - Validatable+Or

public extension Validatable {
    
    /// Performs a logical `OR` (`||`) operation on two Validatables
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    static func || (
        lhs: Self,
        rhs: @autoclosure @escaping () -> Self
    ) -> Validatable {
        DefaultValidatable(
            isValid: lhs.isValid || rhs().isValid
        )
    }
    
}
