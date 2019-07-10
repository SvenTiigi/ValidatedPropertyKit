//
//  ValidationCollectionTests.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationCollectionTests: XCTestCase {
    
    static var allTests = [
        ("testNonEmpty", testNonEmpty),
        ("testRange", testRange)
    ]
    
    func testNonEmpty() {
        let validStrings = ["1"]
        let invalidStrings: [String] = .init()
        let validation = Validation<[String]>.nonEmpty
        XCTAssert(validation.isValid(value: validStrings).isSuccess)
        XCTAssertFalse(validation.isValid(value: invalidStrings).isSuccess)
    }
    
    func testRange() {
        struct FakeRangeExpression: RangeExpression {
            var containsResult: Bool
            func relative<C: Collection>(to collection: C) -> Range<Int> where C.Index == Int {
                return 0..<1
            }
            func contains(_ element: Int) -> Bool {
                return self.containsResult
            }
        }
        let fakeRangeExpressionTrue = FakeRangeExpression(containsResult: true)
        let validatedTrue = Validation<[String]>.range(fakeRangeExpressionTrue)
        XCTAssert(validatedTrue.isValid(value: .init()).isSuccess)
        let fakeRangeExpressionFalse = FakeRangeExpression(containsResult: false)
        let validatedFalse = Validation<[String]>.range(fakeRangeExpressionFalse)
        XCTAssertFalse(validatedFalse.isValid(value: .init()).isSuccess)
    }
    
}
