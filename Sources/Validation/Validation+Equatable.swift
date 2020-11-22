//
//  Validation+Equatable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Equatable

public extension Validation where Value: Equatable {
    
    /// Returns a Validation indicating whether two values are equal.
    /// - Parameter equatableValue: The Equatable value
    static func equals(
        _ equatableValue: Value
    ) -> Self {
        .init { value in
            value == equatableValue
        }
    }
    
}
