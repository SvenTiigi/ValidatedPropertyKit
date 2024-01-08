import Foundation

// MARK: - Validation

/// A Validation
public struct Validation<Value> {
    // MARK: Typealias
    
    /// The validation predicate typealias representing a `(Value) -> Bool` closure
    public typealias Predicate = (Value) throws -> Bool
    
    // MARK: Properties
    
    /// The Predicate
    private let predicate: Predicate
    
    public let error: String?
    
    // MARK: Initializer
    
    /// Creates a new instance of `Validation`
    /// - Parameter predicate: A closure that takes a value and returns a Boolean value if the passed value is valid
    public init(
        predicate: @escaping Predicate,
        error: String? = nil
    ) {
        self.predicate = predicate
        self.error = error
    }
    
    /// Creates a new instance of `Validation`
    /// - Parameters:
    ///   - validation: The WrappedValue Validation
    ///   - isNilValid: A closure that returns a Boolean value if `nil` should be treated as valid or not. Default value `false`
    public init<WrappedValue>(
        _ validation: Validation<WrappedValue>,
        isNilValid: @autoclosure @escaping () -> Bool = false
    ) where WrappedValue? == Value {
        self.init(
            predicate: { value in
                value.flatMap { v in
                    do {
                        try validation.validate(v)
                        return true
                    } catch {
                        return false
                    }
                    
                } ?? isNilValid()
            },
            error: validation.error
        )
    }
}

// MARK: - Validate

public extension Validation {
    func validate(
        _ value: Value
    ) throws {
        let isValid = try predicate(value)
        
        if !isValid {
            throw error ?? "Not valid"
        }
    }
    
    func validateCatched(
        _ value: Value
    ) -> Bool {
        do {
            try validate(value)
            return true
        } catch {
            return false
        }
    }
}

extension String: Error {}
