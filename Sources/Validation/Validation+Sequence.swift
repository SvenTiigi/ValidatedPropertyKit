//
//  Validation+Sequence.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Sequence

public extension Validation where Value: Sequence, Value.Element: Equatable {
    
    /// Validation with contains elements
    /// - Parameter elements: The Elements that should be contained
    static func contains(
        _ elements: Value.Element...
    ) -> Self {
        .init { value in
            elements.map(value.contains).contains(true)
        }
    }
    
    /// Returns a Validation indicating whether the initial elements
    /// of the sequence are the same as the elements in another sequence
    /// - Parameter elements: The Elements to compare to
    static func startsWith(
        _ elements: Value.Element...
    ) -> Self {
        .init { value in
            value.starts(with: elements)
        }
    }
    
}
