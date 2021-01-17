//
//  Validatable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 04.01.21.
//  Copyright © 2021 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validatable

/// A Validatable type
public protocol Validatable {
    
    /// Bool value if is valid
    var isValid: Bool { get }
    
}
