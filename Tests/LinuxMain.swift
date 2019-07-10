import XCTest
@testable import ValidatedPropertyKitTests

XCTMain([
    testCase(ValidatedTests.allTests),
    testCase(OptionalableTests.allTests),
    testCase(ValidationEquatableTests.allTests),
    testCase(ValidationStringTests.allTests),
    testCase(ValidationSequenceTests.allTests),
    testCase(ValidationCollectionTests.allTests),
    testCase(ValidationComparableTests.allTests)
])
