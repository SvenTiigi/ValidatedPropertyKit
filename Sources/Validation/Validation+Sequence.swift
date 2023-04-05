import Foundation

// MARK: - Validation+Sequence

public extension Validation where Value: Sequence, Value.Element: Equatable {
    /// Validation with contains elements
    /// - Parameter elements: The Elements that should be contained
    static func contains(
        _ elements: Value.Element...,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                elements.map(value.contains).contains(true)
            },
            error: error
        )
    }

    /// Returns a Validation indicating whether the initial elements
    /// of the sequence are the same as the elements in another sequence
    /// - Parameter elements: The Elements to compare to
    static func startsWith(
        _ elements: Value.Element...,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                value.starts(with: elements)
            },
            error: error
        )
    }
}
