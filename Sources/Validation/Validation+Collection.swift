import Foundation

// MARK: - Validation+Collection

public extension Validation where Value: Collection {
    
    /// The isEmpty Validation
    static var isEmpty: Self {
        .init { value in
            value.isEmpty
        }
    }
    
    /// Validation with RangeExpression
    /// - Parameter range: The RangeExpression
    static func range<R: RangeExpression>(
        _ range: @autoclosure @escaping () -> R
    ) -> Self where R.Bound == Int {
        .init { value in
            range().contains(value.count)
        }
    }
    
}
