import Foundation

// MARK: - Validation+KeyPath

public extension Validation {
    /// Validation via KeyPath
    /// - Parameters:
    ///   - keyPath: A key path from a specific root type to a specific resulting value type
    ///   - validation: The Validation for the specific resulting value type
    static func keyPath<T>(
        _ keyPath: @autoclosure @escaping () -> KeyPath<Value, T>,
        _ validation: @autoclosure @escaping () -> Validation<T>,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                validation().validateCatched(value[keyPath: keyPath()])
            },
            error: error
        )
    }

    /// Validation that checks if a given Bool value KeyPath evaluates to `true`
    /// - Parameter keyPath: The Bool value KeyPath
    static func keyPath(
        _ keyPath: @autoclosure @escaping () -> KeyPath<Value, Bool>,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                value[keyPath: keyPath()]
            },
            error: error
        )
    }
}
