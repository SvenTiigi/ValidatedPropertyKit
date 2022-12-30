import Foundation

// MARK: - Validation+Constant

public extension Validation {
    
    /// Constant Validation which always evalutes to a given Bool value
    /// - Parameter isValid: The isValid Bool value
    static func constant(
        _ isValid: @autoclosure @escaping () -> Bool
    ) -> Self {
        .init { _ in isValid() }
    }
    
}
