//
//  Validation+Constant.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 22.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Constant

public extension Validation {
    
    /// Constant Validation which always evalutes to a given Bool value
    /// - Parameter isValid: The isValid Bool value
    static func constant(
        _ isValid: Bool
    ) -> Self {
        .init { _ in isValid }
    }
    
}
