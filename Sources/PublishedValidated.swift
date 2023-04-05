//
//  PublishedValidated.swift
//
//
//  Created by Jan Švec on 31.03.2023.
//

import Combine
import SwiftUI

@available(iOS 14.0, *)
@propertyWrapper
public final class PublishedValidated<Value: Equatable>: ObservableObject, Validatable {
    public var validation: Validation<Value> {
        didSet {
            validate()
        }
    }

    @Published
    public private(set) var value: Value

    @Published
    public private(set) var hasChanges = false

    @Published
    public private(set) var isValid: Bool

    @Published
    public private(set) var error: String?

    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            if newValue == value { return }

            value = newValue
            validate()

            if !hasChanges {
                hasChanges.toggle()
            }
        }
    }

    public var projectedValue: Published<Value>.Publisher {
        get {
            return $value
        }
        set {
            $value = newValue
            validate()

            if !hasChanges {
                hasChanges.toggle()
            }
        }
    }

    public var isInvalidAfterChanges: Bool {
        hasChanges && !isValid
    }

    public var errorAfterChanges: String? {
        isInvalidAfterChanges ? error : nil
    }

    public func validate() {
        do {
            try validation.validate(value)
            isValid = true
            error = nil
        } catch {
            self.error = error as? String
            isValid = false
        }
    }

    public init(
        wrappedValue: Value,
        _ validation: Validation<Value>
    ) {
        self.validation = validation

        _value = .init(
            initialValue: wrappedValue
        )

        _isValid = .init(
            initialValue: validation.validateCatched(wrappedValue)
        )
    }
}
