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
    
    func testContains() {
        let validStrings = ["1", "2", "3"]
        let invalidStrings = ["2", "3", "4"]
        let validation = Validation<[String]>.contains("1")
        XCTAssert(validation.isValid(value: validStrings))
        XCTAssertFalse(validation.isValid(value: invalidStrings))
    }
    
    func testStartsWith() {
        let validStrings = ["1", "2", "3"]
        let invalidStrings = ["2", "3", "4"]
        let validation = Validation<[String]>.startsWith("1", "2")
        XCTAssert(validation.isValid(value: validStrings))
        XCTAssertFalse(validation.isValid(value: invalidStrings))
    }
    
}
