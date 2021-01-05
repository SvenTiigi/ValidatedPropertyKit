//
//  Validation+String.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Validation+StringProtocol

public extension Validation where Value: StringProtocol {
    
    /// Validation with contains String
    /// - Parameters:
    ///   - string: The String that should be contained
    ///   - options: The String ComparisonOptions. Default value `.init`
    static func contains<S: StringProtocol>(
        _ string: S,
        options: NSString.CompareOptions = .init()
    ) -> Validation {
        .init { value in
            value.range(of: string, options: options) != nil
        }
    }
    
    /// Validation with has prefix
    /// - Parameter prefix: The prefix
    static func hasPrefix<S: StringProtocol>(
        _ prefix: S
    ) -> Validation {
        .init { value in
            value.hasPrefix(prefix)
        }
    }
    
    /// Validation with has suffix
    /// - Parameter suffix: The suffix
    static func hasSuffix<S: StringProtocol>(
        _ suffix: S
    ) -> Validation {
        .init { value in
            value.hasSuffix(suffix)
        }
    }
    
}

// MARK: - Validation+String

public extension Validation where Value == String {
    
    /// Validation with RegularExpression
    /// - Parameters:
    ///   - regularExpression: The NSRegularExpression
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ regularExpression: NSRegularExpression,
        matchingOptions: NSRegularExpression.MatchingOptions = .init()
    ) -> Self {
        .init { value in
            regularExpression.firstMatch(
                in: value,
                options: matchingOptions,
                range: .init(value.startIndex..., in: value)
            ) != nil
        }
    }
    
    /// Validation with RegularExpression Pattern
    /// - Parameters:
    ///   - pattern: The RegularExpression Pattern
    ///   - onInvalidPatternValidation: The Validation that should be used when the pattern is invalid. Default value `.always(false)`
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ pattern: String,
        onInvalidPatternValidation: @autoclosure @escaping () -> Validation<Void> = .always(false),
        matchingOptions: NSRegularExpression.MatchingOptions = .init()
    ) -> Self {
        do {
            return self.regularExpression(
                try NSRegularExpression(pattern: pattern),
                matchingOptions: matchingOptions
            )
        } catch {
            return .init { _ in
                onInvalidPatternValidation().isValid(value: ())
            }
        }
    }
    
}
