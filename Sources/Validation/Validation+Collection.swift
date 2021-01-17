//
//  Validation+Collection.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

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
        _ range: R
    ) -> Self where R.Bound == Int {
        .init { value in
            range.contains(value.count)
        }
    }
    
}
