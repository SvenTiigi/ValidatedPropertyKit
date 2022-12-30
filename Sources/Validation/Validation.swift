import Foundation

// MARK: - Validation

/// A Validation
public struct Validation<Value> {
    
    // MARK: Typealias
    
    /// The validation predicate typealias representing a `(Value) -> Bool` closure
    public typealias Predicate = (Value) -> Bool
    
    // MARK: Properties
    
    /// The Predicate
    private let predicate: Predicate
    
    // MARK: Initializer
    
    /// Creates a new instance of `Validation`
    /// - Parameter predicate: A closure that takes a value and returns a Boolean value if the passed value is valid
    public init(
        predicate: @escaping Predicate
    ) {
        self.predicate = predicate
    }
    
    /// Creates a new instance of `Validation`
    /// - Parameters:
    ///   - validation: The WrappedValue Validation
    ///   - isNilValid: A closure that returns a Boolean value if `nil` should be treated as valid or not. Default value `false`
    public init<WrappedValue>(
        _ validation: Validation<WrappedValue>,
        isNilValid: @autoclosure @escaping () -> Bool = false
    ) where WrappedValue? == Value {
        self.init { value in
            value.flatMap(validation.validate) ?? isNilValid()
        }
    }
    
}

// MARK: - Validate

public extension Validation {
    
    /// Validates a value and returns a Boolean value wether the value is valid or invalid
    /// - Parameter value: The value that should be validated
    /// - Returns: A Boolen value wether the value is valid or invalid
    func validate(
        _ value: Value
    ) -> Bool {
        self.predicate(value)
    }
    
}
