//
//  ValidationEquatableTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationEquatableTests: XCTestCase {

    static var allTests = [
        ("testEqual", testEqual)
    ]
    
    func testEqual() {
        let validation = Validation<String>.equals("1")
        XCTAssert(validation.isValid(value: "1").isSuccess)
        XCTAssertFalse(validation.isValid(value: "0").isSuccess)
    }
    
}
