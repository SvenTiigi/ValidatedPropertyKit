//
//  Optionalable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
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
