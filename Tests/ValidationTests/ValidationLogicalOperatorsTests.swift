//
//  ValidationLogicalOperatorsTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationLogicalOperatorsTests: XCTestCase {
    
    static var allTests = [
        ("testNot", testNot),
        ("testAnd", testAnd),
        ("testOr", testOr)
    ]
    
    func testNot() {
        let bool: Bool = .random()
        let validation = Validation<Int?> { _ in bool }
        XCTAssertEqual(!bool, (!validation).isValid(value: 0))
    }
    
    func testAnd() {
        func testAnd(lhs: Bool, rhs: Bool) {
            let validation1 = Validation<Int?> { _ in lhs }
            let validation2 = Validation<Int?> { _ in rhs }
            XCTAssertEqual(
                lhs && rhs,
                (validation1 && validation2).isValid(value: 0)
            )
        }
        testAnd(lhs: true, rhs: true)
        testAnd(lhs: true, rhs: false)
        testAnd(lhs: false, rhs: true)
        testAnd(lhs: false, rhs: false)
    }
    
    func testOr() {
        func testOr(lhs: Bool, rhs: Bool) {
            let validation1 = Validation<Int?> { _ in lhs }
            let validation2 = Validation<Int?> { _ in rhs }
            XCTAssertEqual(
                lhs || rhs,
                (validation1 || validation2).isValid(value: 0)
            )
        }
        testOr(lhs: true, rhs: true)
        testOr(lhs: true, rhs: false)
        testOr(lhs: false, rhs: true)
        testOr(lhs: false, rhs: false)
    }
    
}
