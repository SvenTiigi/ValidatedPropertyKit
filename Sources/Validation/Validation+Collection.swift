//
//  Validation+Collection.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Collection

public extension Validation where Value: Collection {
    
    /// The non empty Validation
    static var nonEmpty: Validation {
        return .init { value in
            if !value.isEmpty {
                return .success
            } else {
                return .failure("Is empty")
            }
        }
    }
    
    /// Validation with RangeExpression
    ///
    /// - Parameter range: The RangeExpression
    /// - Returns: The Range Validation
    static func range<R: RangeExpression>(_ range: R) -> Validation where R.Bound == Int {
        return .init { value in
            if range.contains(value.count) {
                return .success
            } else {
                return .failure("Range (\(range)) is out of bounds")
            }
        }
    }
    
}
