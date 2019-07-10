//
//  ValidationError.swift
//  ValidatedPropertyKit-iOS
//
//  Created by Sven Tiigi on 05.07.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - ValidationError

/// The ValidationError
public struct ValidationError: Codable, Equatable, Hashable {
    
    // MARK: Properties
    
    /// The messages
    let messages: [String]
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter messages: The messages
    public init(messages: [String]) {
        self.messages = messages
    }
    
    /// Designated Initializer with message
    ///
    /// - Parameter message: The message
    public init(message: String) {
        self.init(messages: [message])
    }
    
}

// MARK: - LocalizedError

extension ValidationError: LocalizedError {
    
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        return self.description
    }
    
    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        return self.description
    }
    
}

// MARK: - CustomStringConvertible

extension ValidationError: CustomStringConvertible {
    
    /// A textual representation of this instance.
    public var description: String {
        return self.messages.joined(separator: "\n")
    }
    
}

// MARK: - ExpressibleByStringLiteral

extension ValidationError: ExpressibleByStringLiteral {
    
    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(stringLiteral value: String) {
        self.init(message: value)
    }
    
}

// MARK: - ExpressibleByStringInterpolation

extension ValidationError: ExpressibleByStringInterpolation {}
