//
//  Validation+Sequence.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Sequence

public extension Validation where Value: Sequence, Value.Element: Equatable {
    
    /// Validation with contains elements
    ///
    /// - Parameter elements: The Elements that should be contained
    /// - Returns: The contains elements Validation
    static func contains(_ elements: Value.Element...) -> Validation {
        return .init { value in
            if elements.map(value.contains).contains(true) {
                return .success
            } else {
                return .failure("(\(elements)) are not contained in \(value)")
            }
        }
    }
    
    /// Returns a Validation indicating whether the initial elements
    /// of the sequence are the same as the elements in another sequence
    ///
    /// - Parameter elements: The Elements to compare to
    /// - Returns: The startsWith elements Validation
    static func startsWith(_ elements: Value.Element...) -> Validation {
        return .init { value in
            if value.starts(with: elements) {
                return .success
            } else {
                return .failure("\(value) is not starting with \(elements)")
            }
        }
    }
    
}
