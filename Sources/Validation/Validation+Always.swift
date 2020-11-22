//
//  Validation+Always.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 22.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+Always

public extension Validation {
    
    /// Always Validation which always evalutes to a given Bool value
    /// - Parameter isValid: The isValid Bool value
    static func always(
        _ isValid: Bool = true
    ) -> Self {
        .init { _ in isValid }
    }
    
}
