//
//  ValidationStringTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidationStringTests: XCTestCase {
    
    static var allTests = [
        ("testContains", testContains),
        ("testHasPrefix", testHasPrefix),
        ("testHasSuffx", testHasSuffx),
        ("testRegularExpressionPattern", testRegularExpressionPattern),
        ("testLowercased", testLowercased),
        ("testUppercased", testUppercased),
        ("testEmail", testEmail),
        ("testURL", testURL),
        ("testNumeric", testNumeric)
    ]

    
    func testContains() {
        let string = UUID().uuidString
        let substring1 = String(string.prefix(.random(in: 0..<string.count)))
        let substring2 = UUID().uuidString
        let validation1 = Validation<String>.contains(substring1, options: .caseInsensitive)
        XCTAssert(validation1.isValid(value: string))
        let validation2 = Validation<String>.contains(substring2)
        XCTAssertFalse(validation2.isValid(value: string))
    }
    
    func testHasPrefix() {
        let string = UUID().uuidString
        let substring1 = String(string.prefix(.random(in: 0..<string.count)))
        let substring2 = UUID().uuidString
        let validation1 = Validation<String>.hasPrefix(substring1)
        XCTAssert(validation1.isValid(value: string))
        let validation2 = Validation<String>.hasPrefix(substring2)
        XCTAssertFalse(validation2.isValid(value: string))
    }
    
    func testHasSuffx() {
        let string = UUID().uuidString
        let substring1 = String(string.suffix(.random(in: 0..<string.count)))
        let substring2 = UUID().uuidString
        let validation1 = Validation<String>.hasSuffix(substring1)
        XCTAssert(validation1.isValid(value: string))
        let validation2 = Validation<String>.hasSuffix(substring2)
        XCTAssertFalse(validation2.isValid(value: string))
    }
    
    func testRegularExpressionPattern() {
        let validRegularExpressionPattern = "[0-9]+$"
        let validString = "123456789"
        let invalidString = "ABCDEFGHIJ"
        let invalidRegularExpressionPattern = ""
        let validatation = Validation<String>.regularExpression(validRegularExpressionPattern)
        XCTAssert(validatation.isValid(value: validString))
        XCTAssertFalse(validatation.isValid(value: invalidString))
        let validation2 = Validation<String>.regularExpression(invalidRegularExpressionPattern)
        XCTAssertFalse(validation2.isValid(value: validString))
        XCTAssertFalse(validation2.isValid(value: invalidString))
    }
    
    func testLowercased() {
        let string = UUID().uuidString
        let validation = Validation<String>.isLowercased
        XCTAssert(validation.isValid(value: string.lowercased()))
        XCTAssertFalse(validation.isValid(value: string.uppercased()))
    }
    
    func testUppercased() {
        let string = UUID().uuidString
        let validation = Validation<String>.isUppercased
        XCTAssert(validation.isValid(value: string.uppercased()))
        XCTAssertFalse(validation.isValid(value: string.lowercased()))
    }
    
    func testEmail() {
        let validation = Validation<String>.isEmail
        let validEMail = "mr.robot@fsociety.com"
        let invalidEMail = UUID().uuidString
        XCTAssert(validation.isValid(value: validEMail))
        XCTAssertFalse(validation.isValid(value: invalidEMail))
    }
    
    func testURL() {
        let validation = Validation<String>.isURL
        let validURL = "https://www.google.de"
        let validURL2 = "http://www.google.de"
        let validURL3 = "https://google.de"
        let invalidURL = UUID().uuidString
        XCTAssert(validation.isValid(value: validURL))
        XCTAssert(validation.isValid(value: validURL2))
        XCTAssert(validation.isValid(value: validURL3))
        XCTAssertFalse(validation.isValid(value: invalidURL))
    }
    
    func testNumeric() {
        let validation = Validation<String>.isNumeric
        let validFloat = "100"
        let invalidFloat = "ABCDEFGHIJ"
        XCTAssert(validation.isValid(value: validFloat))
        XCTAssertFalse(validation.isValid(value: invalidFloat))
    }
    
}
