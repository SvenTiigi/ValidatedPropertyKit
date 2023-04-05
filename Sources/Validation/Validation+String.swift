import Foundation

// MARK: - Validation+StringProtocol

public extension Validation where Value: StringProtocol {
    /// Validation with contains String
    /// - Parameters:
    ///   - string: The String that should be contained
    ///   - options: The String ComparisonOptions. Default value `.init`
    static func contains<S: StringProtocol>(
        _ string: @autoclosure @escaping () -> S,
        options: @autoclosure @escaping () -> NSString.CompareOptions = .init(),
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                value.range(of: string(), options: options()) != nil
            },
            error: error
        )
    }
    
    /// Validation with has prefix
    /// - Parameter prefix: The prefix
    static func hasPrefix<S: StringProtocol>(
        _ prefix: @autoclosure @escaping () -> S,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                value.hasPrefix(prefix())
            },
            error: error
        )
    }
    
    /// Validation with has suffix
    /// - Parameter suffix: The suffix
    static func hasSuffix<S: StringProtocol>(
        _ suffix: @autoclosure @escaping () -> S,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                value.hasSuffix(suffix())
            },
            error: error
        )
    }
}

// MARK: - Validation+String

public extension Validation where Value == String {
    /// Validation if the String is a subset of a given CharacterSet
    /// - Parameter characterSet: The CharacterSet
    static func isSubset(
        of characterSet: @autoclosure @escaping () -> CharacterSet,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                CharacterSet(
                    charactersIn: value
                )
                .isSubset(
                    of: characterSet()
                )
            },
            error: error
        )
    }
    
    /// Validation if the String is numeric
    /// - Parameter locale: The Locale. Default value `.current`
    static func isNumeric(
        locale: @autoclosure @escaping () -> Locale = .current,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                let scanner = Scanner(string: value)
                scanner.locale = locale()
                return scanner.scanDecimal() != nil && scanner.isAtEnd
            },
            error: error
        )
    }
    
    /// Validation if the String matches with a given NSTextCheckingResult CheckingType
    /// - Parameters:
    ///   - textCheckingResult: The NSTextCheckingResult CheckingType
    ///   - validate: An optional closure to validate the NSTextCheckingResult. Default value `nil`
    static func matches(
        _ textCheckingResult: @autoclosure @escaping () -> NSTextCheckingResult.CheckingType,
        validate: ((NSTextCheckingResult) -> Bool)? = nil,
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                // Initialize NSDataDetector with link checking type
                let detector = try? NSDataDetector(
                    types: textCheckingResult().rawValue
                )
                // Initialize Range from value
                let range = NSRange(
                    value.startIndex ..< value.endIndex,
                    in: value
                )
                // Retrieve matches from value
                let matches = detector?.matches(
                    in: value,
                    options: .init(),
                    range: range
                )
                // Verify first Match is available and the match matches the range
                guard let match = matches?.first, match.range == range else {
                    // Otherwise return false
                    return false
                }
                // Check if the match is invalid
                if validate?(match) == false {
                    // Return false
                    return false
                }
                // Return true
                return true
            },
            error: error
        )
    }
    
    /// Validation if a given String is a valid mail address
    static func isEmail(error: String? = nil) -> Self {
        self.matches(.link,
                     validate: { match in
                         match.url?.scheme == "mailto"
                     },
                     error: error)
    }
    
    /// Validation with RegularExpression
    /// - Parameters:
    ///   - regularExpression: The NSRegularExpression
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ regularExpression: @autoclosure @escaping () -> NSRegularExpression,
        matchingOptions: @autoclosure @escaping () -> NSRegularExpression.MatchingOptions = .init(),
        error: String? = nil
    ) -> Self {
        .init(
            predicate: { value in
                regularExpression().firstMatch(
                    in: value,
                    options: matchingOptions(),
                    range: .init(value.startIndex..., in: value)
                ) != nil
            },
            error: error
        )
    }
    
    /// Validation with RegularExpression Pattern
    /// - Parameters:
    ///   - pattern: The RegularExpression Pattern
    ///   - onInvalidPatternValidation: The Validation that should be used when the pattern is invalid. Default value `.constant(false)`
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ pattern: @autoclosure @escaping () -> String,
        onInvalidPatternValidation: @autoclosure @escaping () -> Validation<Void> = .constant(false),
        matchingOptions: @autoclosure @escaping () -> NSRegularExpression.MatchingOptions = .init(),
        error: String? = nil
    ) -> Self {
        let regularExpression: NSRegularExpression
        do {
            regularExpression = try .init(pattern: pattern())
        } catch {
            return .init { _ in
                onInvalidPatternValidation().validateCatched(())
            }
        }
        return self.regularExpression(
            regularExpression,
            matchingOptions: matchingOptions(),
            error: error
        )
    }
    
    @available(iOS 16.0, *)
    static func regex<T>(_ regex: Regex<T>, error: String? = nil) -> Self {
        .init(
            predicate: { value in
                value.contains(regex)
            },
            error: error
        )
    }
}
