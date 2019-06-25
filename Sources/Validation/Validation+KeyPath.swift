//
//  Validation+KeyPath.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 23.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+KeyPath

public extension Validation {
    
    /// Validation via KeyPath
    ///
    /// - Parameters:
    ///   - keyPath: A key path from a specific root type to a specific resulting value type
    ///   - validation: The Validation for the specific resulting value type
    /// - Returns: A Validation
    static func keyPath<T>(_ keyPath: KeyPath<Value, T>,
                           _ validation: Validation<T>) -> Validation {
        return .init { value in
            return validation.isValid(value: value[keyPath: keyPath])
        }
    }
    
}
