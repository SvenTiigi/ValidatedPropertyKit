import Foundation

// MARK: - Validation+BinaryInteger

public extension Validation where Value: BinaryInteger {
    
    /// Validation that validates if thie value is a multiple of the given value
    /// - Parameter other: The other Value
    static func isMultiple(
        of other: @autoclosure @escaping () -> Value
    ) -> Self {
        .init { value in
            value.isMultiple(of: other())
        }
    }
    
}
