import Foundation

// MARK: - Validation+Equatable

public extension Validation where Value: Equatable {
    
    /// Returns a Validation indicating whether two values are equal.
    /// - Parameter equatableValue: The Equatable value
    static func equals(
        _ equatableValue: @autoclosure @escaping () -> Value
    ) -> Self {
        .init { value in
            value == equatableValue()
        }
    }
    
}
