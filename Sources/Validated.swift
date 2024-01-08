import SwiftUI

// MARK: - Validated

/// A Validated PropertyWrapper
@propertyWrapper
public struct Validated<Value>: Validatable, DynamicProperty {
    // MARK: Properties
    
    /// The Validation
    public var validation: Validation<Value> {
        didSet {
            self.revalidate()
        }
    }
    
    /// The Value
    @State
    private var value: Value
    
    /// Bool value if the value has been modified
    @State
    public private(set) var hasChanges = false
    
    /// Bool value if validated value is valid
    @State
    public private(set) var isValid: Bool
    
    // MARK: PropertyWrapper-Properties
    
    /// The underlying value referenced by the Validated variable
    public var wrappedValue: Value {
        get {
            self.projectedValue.wrappedValue
        }
        nonmutating set {
            self.projectedValue.wrappedValue = newValue
        }
    }
    
    /// A binding to the Validated value
    public var projectedValue: Binding<Value> {
        .init(
            get: {
                self.value
            },
            set: { newValue in
                self.value = newValue
                if !self.hasChanges {
                    self.hasChanges.toggle()
                }
                
                revalidate()
            }
        )
    }
    
    // MARK: Initializer
    
    /// Creates a new instance of `Validated`
    /// - Parameters:
    ///   - wrappedValue: The wrapped `Value`
    ///   - validation: The `Validation`
    public init(
        wrappedValue: Value,
        _ validation: Validation<Value>
    ) {
        self.validation = validation
        self._value = .init(initialValue: wrappedValue)
        
        var isValid = false
        do {
            try validation.validate(wrappedValue)
            isValid = true
        } catch {}
        
        self._isValid = .init(initialValue: isValid)
    }
    
    /// Creates a new instance of `Validated`
    /// - Parameters:
    ///   - wrappedValue: The  `WrappedValue`. Default value `nil`
    ///   - validation: The `Validation`
    ///   - isNilValid: A closure that returns a Boolean value if `nil` should be treated as valid or not. Default value `false`
    public init<WrappedValue>(
        wrappedValue: WrappedValue? = nil,
        _ validation: Validation<WrappedValue>,
        isNilValid: @autoclosure @escaping () -> Bool = false
    ) where WrappedValue? == Value {
        self.init(
            wrappedValue: wrappedValue,
            .init(
                validation,
                isNilValid: isNilValid()
            )
        )
    }
    
    func revalidate() {
        self.isValid = self.validate()
    }
    
    func validate() -> Bool {
        do {
            try self.validation.validate(self.value)
            return true
        } catch {
            return false
        }
    }
}

// MARK: - Validated+validatedValue

public extension Validated {
    /// The value if is valid otherwise returns `nil`
    var validatedValue: Value? {
        self.isValid ? self.value : nil
    }
}

// MARK: - Validated+isInvalid

public extension Validated {
    /// A Boolean value if the value is invalid
    var isInvalid: Bool {
        !self.isValid
    }
}

// MARK: - Validated+isInvalidAfterChanges

public extension Validated {
    /// A Boolean value if the value is invalid and has been previously modified
    var isInvalidAfterChanges: Bool {
        self.hasChanges && !self.isValid
    }
}

// MARK: - Validated+reset

public extension Validated {

    /// A Boolean value if the value is invalid and has been previously modified
    func reset() {
        self.hasChanges = false
    }

}

