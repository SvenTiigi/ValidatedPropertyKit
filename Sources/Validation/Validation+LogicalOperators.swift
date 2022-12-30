import Foundation

// MARK: - Validation+Not

public extension Validation {
    
    /// Performs a logical `NOT` (`!`) operation on a Validation
    /// - Parameter validation: The Validation value to negate
    static prefix func ! (
        validation: Self
    ) -> Self {
        .init { value in
            !validation.validate(value)
        }
    }
    
}

// MARK: - Validation+And

public extension Validation {
    
    /// Performs a logical `AND` (`&&`) operation on two Validations
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    static func && (
        lhs: Self,
        rhs: @autoclosure @escaping () -> Self
    ) -> Self {
        .init { value in
            lhs.validate(value) && rhs().validate(value)
        }
    }
    
}

// MARK: - Validation+Or

public extension Validation {
    
    /// Performs a logical `OR` (`||`) operation on two Validations
    /// - Parameters:
    ///   - lhs: The left-hand side of the operation
    ///   - rhs: The right-hand side of the operation
    static func || (
        lhs: Self,
        rhs: @autoclosure @escaping () -> Self
    ) -> Self {
        .init { value in
            lhs.validate(value) || rhs().validate(value)
        }
    }
    
}
