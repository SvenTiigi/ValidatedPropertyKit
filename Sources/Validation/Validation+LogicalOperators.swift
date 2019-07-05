//
//  Validation+LogicalOperators.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Not

public extension Validation {
    
    /// Performs a logical `NOT` (`!`) operation on a Validation
    ///
    /// - Parameter validation: The Validation value to negate
    /// - Returns: The negated Validation
    static prefix func ! (_ validation: Validation) -> Validation {
        return .init { value in
            // Return negated validation result
            switch validation.isValid(value: value) {
            case .success:
                return .failure("Validation should not be successful")
            case .failure:
                return .success
            }
        }
    }
    
}

// MARK: - Validation+And

public extension Validation {
    
    /// Performs a logical `AND` (`&&`) operation on two Validations
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    /// - Returns: The new Validation
    static func && (lhs: Validation, rhs: @autoclosure @escaping () -> Validation) -> Validation {
        return .init { value in
            // Return logical AND operation result
            switch (lhs.isValid(value: value), rhs().isValid(value: value)) {
            case (.success, .success):
                return .success
            case (.success, .failure(let error)):
                return .failure(error)
            case (.failure(let error), .success):
                return .failure(error)
            case (.failure(let lhsError), .failure(let rhsError)):
                return .failure(.init(messages: lhsError.messages + rhsError.messages))
            }
        }
    }
    
}

// MARK: - Validation+Or

public extension Validation {
    
    /// Performs a logical `OR` (`||`) operation on two Validations
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    /// - Returns: The new Validation
    static func || (lhs: Validation, rhs: @autoclosure @escaping () -> Validation) -> Validation {
        return .init { value in
            // Return logical OR operation result
            switch (lhs.isValid(value: value), rhs().isValid(value: value)) {
            case (.success, .success):
                return .success
            case (.success, .failure):
                return .success
            case (.failure, .success):
                return .success
            case (.failure(let lhsError), .failure(let rhsError)):
                return .failure(.init(messages: lhsError.messages + rhsError.messages))
            }
        }
    }
    
}
