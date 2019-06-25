//
//  ValidationComparisonOperatorsTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationComparisonOperatorsTests: XCTestCase {

    static var allTests = [
        ("testEqual", testEqual),
        ("testUnequal", testUnequal)
    ]
    
    func testEqual() {
        func testEqual(lhs: Bool, rhs: Bool) {
            let validation1 = Validation<Int?> { _ in lhs }
            let validation2 = Validation<Int?> { _ in rhs }
            XCTAssertEqual(
                lhs == rhs,
                (validation1 == validation2).isValid(value: 0)
            )
        }
        testEqual(lhs: true, rhs: true)
        testEqual(lhs: true, rhs: false)
        testEqual(lhs: false, rhs: true)
        testEqual(lhs: false, rhs: false)
    }
    
    func testUnequal() {
        func testUnequal(lhs: Bool, rhs: Bool) {
            let validation1 = Validation<Int?> { _ in lhs }
            let validation2 = Validation<Int?> { _ in rhs }
            XCTAssertEqual(
                lhs != rhs,
                (validation1 != validation2).isValid(value: 0)
            )
        }
        testUnequal(lhs: true, rhs: true)
        testUnequal(lhs: true, rhs: false)
        testUnequal(lhs: false, rhs: true)
        testUnequal(lhs: false, rhs: false)
    }
    
}
