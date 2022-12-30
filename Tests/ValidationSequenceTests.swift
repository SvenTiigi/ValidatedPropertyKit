@testable import ValidatedPropertyKit
import XCTest

class ValidationSequenceTests: XCTestCase {
    
    func testContains() {
        let validStrings = ["1", "2", "3"]
        let invalidStrings = ["2", "3", "4"]
        let validation = Validation<[String]>.contains("1")
        XCTAssert(validation.validate(validStrings))
        XCTAssertFalse(validation.validate(invalidStrings))
    }
    
    func testStartsWith() {
        let validStrings = ["1", "2", "3"]
        let invalidStrings = ["2", "3", "4"]
        let validation = Validation<[String]>.startsWith("1", "2")
        XCTAssert(validation.validate(validStrings))
        XCTAssertFalse(validation.validate(invalidStrings))
    }
    
}
