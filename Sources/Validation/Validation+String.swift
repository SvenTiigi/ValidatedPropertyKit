import Foundation

// MARK: - Validation+StringProtocol

public extension Validation where Value: StringProtocol {
    
    /// Validation with contains String
    /// - Parameters:
    ///   - string: The String that should be contained
    ///   - options: The String ComparisonOptions. Default value `.init`
    static func contains<S: StringProtocol>(
        _ string: @autoclosure @escaping () -> S,
        options: @autoclosure @escaping () -> NSString.CompareOptions = .init()
    ) -> Self {
        .init { value in
            value.range(of: string(), options: options()) != nil
        }
    }
    
    /// Validation with has prefix
    /// - Parameter prefix: The prefix
    static func hasPrefix<S: StringProtocol>(
        _ prefix: @autoclosure @escaping () -> S
    ) -> Self {
        .init { value in
            value.hasPrefix(prefix())
        }
    }
    
    /// Validation with has suffix
    /// - Parameter suffix: The suffix
    static func hasSuffix<S: StringProtocol>(
        _ suffix: @autoclosure @escaping () -> S
    ) -> Self {
        .init { value in
            value.hasSuffix(suffix())
        }
    }
    
}

// MARK: - Validation+String

public extension Validation where Value == String {
    
    /// Validation if the String is a subset of a given CharacterSet
    /// - Parameter characterSet: The CharacterSet
    static func isSubset(
        of characterSet: @autoclosure @escaping () -> CharacterSet
    ) -> Self {
        .init { value in
            CharacterSet(
                charactersIn: value
            )
            .isSubset(
                of: characterSet()
            )
        }
    }
    
    /// Validation if the String is numeric
    /// - Parameter locale: The Locale. Default value `.current`
    static func isNumeric(
        locale: @autoclosure @escaping () -> Locale = .current
    ) -> Self {
        .init { value in
            let scanner = Scanner(string: value)
            scanner.locale = locale()
            return scanner.scanDecimal() != nil && scanner.isAtEnd
        }
    }
    
    /// Validation if the String matches with a given NSTextCheckingResult CheckingType
    /// - Parameters:
    ///   - textCheckingResult: The NSTextCheckingResult CheckingType
    ///   - validate: An optional closure to validate the NSTextCheckingResult. Default value `nil`
    static func matches(
        _ textCheckingResult: @autoclosure @escaping () -> NSTextCheckingResult.CheckingType,
        validate: ((NSTextCheckingResult) -> Bool)? = nil
    ) -> Self {
        .init { value in
            // Initialize NSDataDetector with link checking type
            let detector = try? NSDataDetector(
                types: textCheckingResult().rawValue
            )
            // Initialize Range from value
            let range = NSRange(
                value.startIndex..<value.endIndex,
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
        }
    }
    
    /// Validation if a given String is a valid mail address
    static var isEmail: Self {
        self.matches(.link) { match in
            match.url?.scheme == "mailto"
        }
    }
    
    /// Validation with RegularExpression
    /// - Parameters:
    ///   - regularExpression: The NSRegularExpression
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ regularExpression: @autoclosure @escaping () -> NSRegularExpression,
        matchingOptions: @autoclosure @escaping () -> NSRegularExpression.MatchingOptions = .init()
    ) -> Self {
        .init { value in
            regularExpression().firstMatch(
                in: value,
                options: matchingOptions(),
                range: .init(value.startIndex..., in: value)
            ) != nil
        }
    }
    
    /// Validation with RegularExpression Pattern
    /// - Parameters:
    ///   - pattern: The RegularExpression Pattern
    ///   - onInvalidPatternValidation: The Validation that should be used when the pattern is invalid. Default value `.constant(false)`
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ pattern: @autoclosure @escaping () -> String,
        onInvalidPatternValidation: @autoclosure @escaping () -> Validation<Void> = .constant(false),
        matchingOptions: @autoclosure @escaping () -> NSRegularExpression.MatchingOptions = .init()
    ) -> Self {
        let regularExpression: NSRegularExpression
        do {
            regularExpression = try .init(pattern: pattern())
        } catch {
            return .init { _ in
                onInvalidPatternValidation().validate(())
            }
        }
        return self.regularExpression(
            regularExpression,
            matchingOptions: matchingOptions()
        )
    }
    
}
