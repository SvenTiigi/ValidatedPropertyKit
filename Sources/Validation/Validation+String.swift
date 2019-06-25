//
//  Validation+String.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+StringProtocol

public extension Validation where Value: StringProtocol {
    
    /// Validation with contains String
    ///
    /// - Parameters:
    ///   - string: The String that should be contained
    ///   - options: The String ComparisonOptions. Default value `.init`
    /// - Returns: A Validation
    static func contains<S: StringProtocol>(_ string: S,
                                            options: NSString.CompareOptions = .init()) -> Validation {
        return .init { value in
            return value.range(of: string, options: options) != nil
        }
    }
    
    /// Validation with has prefix
    ///
    /// - Parameter prefix: The prefix
    /// - Returns: A Validation
    static func hasPrefix<S: StringProtocol>(_ prefix: S) -> Validation {
        return .init { value in
            return value.hasPrefix(prefix)
        }
    }
    
    /// Validation with has suffix
    ///
    /// - Parameter suffix: The suffix
    /// - Returns: A Validation
    static func hasSuffix<S: StringProtocol>(_ suffix: S) -> Validation {
        return .init { value in
            return value.hasSuffix(suffix)
        }
    }
    
}

// MARK: - Validation+String

public extension Validation where Value == String {
    
    /// Validation with RegularExpression-Pattern
    ///
    /// - Parameters:
    ///   - pattern: The RegularExpression String Pattern
    ///   - options: The NSRegularExpression Options. Default value `.init`
    ///   - matchingOptions: The NSRegularExpression MatchingOptions. Default value `.init`
    /// - Returns: A Validation
    static func regularExpression(_ pattern: String,
                                  options: NSRegularExpression.Options = .init(),
                                  matchingOptions: NSRegularExpression.MatchingOptions = .init()) -> Validation {
        // Verify NSRegularExpression can be constructed with String Pattern
        guard let regularExpression = try? NSRegularExpression(pattern: pattern, options: options) else {
            // Otherwise return Validation that will always fail
            return .init { _ in false }
        }
        // Return RegularExpression Validation
        return self.regularExpression(
            regularExpression,
            matchingOptions: matchingOptions
        )
    }
    
    /// Validation with RegularExpression
    ///
    /// - Parameters:
    ///   - regularExpression: The NSRegularExpression
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    /// - Returns: A Validation
    static func regularExpression(_ regularExpression: NSRegularExpression,
                                  matchingOptions: NSRegularExpression.MatchingOptions = .init()) -> Validation {
        return .init { value in
            // Return Bool if RegularExpression first match is not nil
            return regularExpression.firstMatch(
                in: value,
                options: matchingOptions,
                range: .init(value.startIndex..., in: value)
            ) != nil
        }
    }
    
    /// The Lowercased Validation
    static var isLowercased: Validation {
        return self.regularExpression("^.*?[a-z].*?$")
    }
    
    /// The Uppercased Validation
    static var isUppercased: Validation {
        return self.regularExpression("^.*?[A-Z].*?$")
    }
    
    /// The E-Mail Validation
    static var isEmail: Validation {
        return self.regularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    /// The URL Validation
    static var isURL: Validation {
        return self.regularExpression("(?i)https?://(?:www\\.)?\\S+(?:/|\\b)")
    }
    
    /// The Numeric Validation
    static var isNumeric: Validation {
        return self.regularExpression("[0-9]+$")
    }
    
}
