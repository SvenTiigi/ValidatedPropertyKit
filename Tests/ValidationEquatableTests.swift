@testable import ValidatedPropertyKit
import XCTest

class ValidationEquatableTests: XCTestCase {
    
    func testEqual() {
        let validation = Validation<String>.equals("1")
        XCTAssert(validation.validate("1"))
        XCTAssertFalse(validation.validate("0"))
    }
    
}
