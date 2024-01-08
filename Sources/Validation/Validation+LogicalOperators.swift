import Foundation

// MARK: - Validation+Not

public extension Validation {
    /// Performs a logical `NOT` (`!`) operation on a Validation
    /// - Parameter validation: The Validation value to negate
    static prefix func ! (
        validation: Self
    ) -> Self {
        .init(
            predicate: { value in
                do {
                    try validation.validate(value)
                    return false
                } catch {
                    return true
                }
            },
            error: validation.error
        )
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
            try lhs.validate(value)
            try rhs().validate(value)
            return true
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
            do {
                try lhs.validate(value)
            } catch {
                try rhs().validate(value)
            }

            return true
        }
    }
}
