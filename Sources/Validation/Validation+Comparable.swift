import Foundation

// MARK: - Validation+Comparable

public extension Validation where Value: Comparable {
    
    /// Validation with less `<` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func less(
        _ comparableValue: @autoclosure @escaping () -> Value
    ) -> Self {
        .init { value in
            value < comparableValue()
        }
    }
    
    /// Validation with less or equal `<=` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func lessOrEqual(
        _ comparableValue: @autoclosure @escaping () -> Value
    ) -> Self {
        .init { value in
            value <= comparableValue()
        }
    }
    
    /// Validation with greater `>` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func greater(
        _ comparableValue: @autoclosure @escaping () -> Value
    ) -> Self {
        .init { value in
            value > comparableValue()
        }
    }
    
    /// Validation with greater or equal `>=` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func greaterOrEqual(
        _ comparableValue: @autoclosure @escaping () -> Value
    ) -> Self {
        .init { value in
            value >= comparableValue()
        }
    }
    
}
