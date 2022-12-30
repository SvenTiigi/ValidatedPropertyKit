@testable import ValidatedPropertyKit
import XCTest

class ValidationCollectionTests: XCTestCase {
    
    func testNonEmpty() {
        let validStrings = ["1"]
        let invalidStrings: [String] = .init()
        let validation = !Validation<[String]>.isEmpty
        XCTAssert(validation.validate(validStrings))
        XCTAssertFalse(validation.validate(invalidStrings))
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
        XCTAssert(validatedTrue.validate(.init()))
        let fakeRangeExpressionFalse = FakeRangeExpression(containsResult: false)
        let validatedFalse = Validation<[String]>.range(fakeRangeExpressionFalse)
        XCTAssertFalse(validatedFalse.validate(.init()))
    }
    
}
