//
//  ValidatedTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidatedTests: XCTestCase {
    
    static var allTests = [
        ("testValidated", testValidated)
    ]

    func testValidated() {
        let validValue = 1
        let invalidValue = 0
        var validated = Validated<Int?>(.init { value in
            if value == validValue {
                return .success(())
            } else {
                return .failure("")
            }
        })
        XCTAssertNil(validated.restore())
        XCTAssertNil(validated.value)
        validated.value = validValue
        XCTAssertEqual(validValue, validated.value)
        XCTAssert(validated.isValid)
        validated.value = invalidValue
        XCTAssertNil(validated.value)
        XCTAssertFalse(validated.isValid)
        XCTAssertEqual(validValue, validated.lastSuccessfulValidatedValue)
        validated.restore()
        XCTAssertEqual(validValue, validated.value)
        validated.value = nil
        XCTAssertNil(validated.value)
    }
    
}
