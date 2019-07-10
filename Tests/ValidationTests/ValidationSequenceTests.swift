//
//  ValidationSequenceTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationSequenceTests: XCTestCase {
    
    static var allTests = [
        ("testContains", testContains),
        ("testStartsWith", testStartsWith)
    ]
    
    func testContains() {
        let validStrings = ["1", "2", "3"]
        let invalidStrings = ["2", "3", "4"]
        let validation = Validation<[String]>.contains("1")
        XCTAssert(validation.isValid(value: validStrings).isSuccess)
        XCTAssertFalse(validation.isValid(value: invalidStrings).isSuccess)
    }
    
    func testStartsWith() {
        let validStrings = ["1", "2", "3"]
        let invalidStrings = ["2", "3", "4"]
        let validation = Validation<[String]>.startsWith("1", "2")
        XCTAssert(validation.isValid(value: validStrings).isSuccess)
        XCTAssertFalse(validation.isValid(value: invalidStrings).isSuccess)
    }
    
}
