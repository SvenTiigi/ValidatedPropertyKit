//
//  Validation+Equatable.swift
//  ValidatedPropertyKit-iOS
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Equatable

public extension Validation where Value: Equatable {
    
    /// Returns a Validation indicating whether two values are equal.
    ///
    /// - Parameter equatableValue: The Equatable value
    /// - Returns: A Validation
    static func equals(_ equatableValue: Value) -> Validation {
        return .init { value in
            if value == equatableValue {
                return .success
            } else {
                return .failure("\(value) is not equal to \(equatableValue)")
            }
        }
    }
    
}
