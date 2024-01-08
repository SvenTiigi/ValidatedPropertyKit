import Foundation

// MARK: - Validation+Collection

public extension Validation where Value: Collection {
    static func isEmpty(error: String? = nil) -> Self {
        .init(
            predicate: { value in
                value.isEmpty
            },
            error: error
        )
    }

    /// Validation with RangeExpression
    /// - Parameter range: The RangeExpression
    static func range<R: RangeExpression>(
        _ range: @autoclosure @escaping () -> R,
        error: String? = nil
    ) -> Self where R.Bound == Int {
        .init(
            predicate: { value in
                range().contains(value.count)
            },
            error: error
        )
    }
}
