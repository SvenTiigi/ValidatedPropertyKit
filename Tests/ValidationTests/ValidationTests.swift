//
//  ValidationTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationTests: XCTestCase {
    
    static var allTests = [
        ("testValidation", testValidation)
    ]
    
    func testValidation() {
        let bool: Bool = .random()
        let validation = Validation<Int> { _ in bool }
        XCTAssertEqual(bool, validation.isValid(value: 0))
    }
    
}
