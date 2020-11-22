//
//  Optionalable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 22.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Optionalable

/// The Optionalable protocol
public protocol Optionalable: ExpressibleByNilLiteral {
    
    /// The underlying wrapped type
    associatedtype Wrapped
    
    /// The wrapped value
    var wrapped: Wrapped? { get }
    
    /// Initializer with wrapped value
    ///
    /// - Parameter some: The wrapped value
    init(_ some: Wrapped)
    
}
