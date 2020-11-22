//
//  Validation+KeyPath.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+KeyPath

public extension Validation {
    
    /// Validation via KeyPath
    /// - Parameters:
    ///   - keyPath: A key path from a specific root type to a specific resulting value type
    ///   - validation: The Validation for the specific resulting value type
    static func keyPath<T>(
        _ keyPath: KeyPath<Value, T>,
        _ validation: Validation<T>
    ) -> Self {
        .init { value in
            validation.isValid(value: value[keyPath: keyPath])
        }
    }
    
}
