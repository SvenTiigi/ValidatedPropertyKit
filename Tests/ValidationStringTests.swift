@testable import ValidatedPropertyKit
import XCTest

class ValidationStringTests: XCTestCase {
    
    func testIsEmail() {
        XCTAssert(
            Validation<String>.isEmail.validate("john@doe.com")
        )
        XCTAssertFalse(
            Validation<String>.isEmail.validate(UUID().uuidString)
        )
    }

    func testContains() {
        let string = UUID().uuidString
        let substring1 = String(string.prefix(.random(in: 0..<string.count)))
        let substring2 = UUID().uuidString
        let validation1 = Validation<String>.contains(substring1, options: .caseInsensitive)
        XCTAssert(validation1.validate(string))
        let validation2 = Validation<String>.contains(substring2)
        XCTAssertFalse(validation2.validate(string))
    }
    
    func testHasPrefix() {
        let string = UUID().uuidString
        let substring1 = String(string.prefix(.random(in: 0..<string.count)))
        let substring2 = UUID().uuidString
        let validation1 = Validation<String>.hasPrefix(substring1)
        XCTAssert(validation1.validate(string))
        let validation2 = Validation<String>.hasPrefix(substring2)
        XCTAssertFalse(validation2.validate(string))
    }
    
    func testHasSuffx() {
        let string = UUID().uuidString
        let substring1 = String(string.suffix(.random(in: 0..<string.count)))
        let substring2 = UUID().uuidString
        let validation1 = Validation<String>.hasSuffix(substring1)
        XCTAssert(validation1.validate(string))
        let validation2 = Validation<String>.hasSuffix(substring2)
        XCTAssertFalse(validation2.validate(string))
    }
    
    func testRegularExpressionPattern() {
        let validRegularExpressionPattern = "[0-9]+$"
        let validString = "123456789"
        let invalidString = "ABCDEFGHIJ"
        let invalidRegularExpressionPattern = ""
        let validatation = Validation<String>.regularExpression(validRegularExpressionPattern)
        XCTAssert(validatation.validate(validString))
        XCTAssertFalse(validatation.validate(invalidString))
        let validation2 = Validation<String>.regularExpression(invalidRegularExpressionPattern)
        XCTAssertFalse(validation2.validate(validString))
        XCTAssertFalse(validation2.validate(invalidString))
    }
    
}
