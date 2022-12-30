import Foundation

// MARK: - Validatable

/// A Validatable type
public protocol Validatable {
    
    /// A Bool value specifying if is valid or not
    var isValid: Bool { get }
    
}

// MARK: - DefaultValidatable

/// A Default Validatable
private struct DefaultValidatable: Validatable {
    
    /// A Bool value specifying if is valid or not
    let isValid: Bool
    
}

// MARK: - Validatable+Not

public extension Validatable {
    
    /// Performs a logical `NOT` (`!`) operation on a Validatable type
    /// - Parameter validatable: The Validatable object to negate
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
    
    /// Performs a logical `AND` (`&&`) operation on two Validatable types
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
    
    /// Performs a logical `OR` (`||`) operation on two Validatable types
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
