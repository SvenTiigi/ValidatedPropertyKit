import XCTest
@testable import ValidatedPropertyKitTests

XCTMain([
    testCase(ValidatedTests.allTests),
    testCase(OptionalableTests.allTests),
    testCase(ValidationTests.allTests),
    testCase(ValidationLogicalOperatorsTests.allTests),
    testCase(ValidationComparisonOperatorsTests.allTests),
    testCase(ValidationEquatableTests.allTests),
    testCase(ValidationStringTests.allTests),
    testCase(ValidationSequenceTests.allTests),
    testCase(ValidationCollectionTests.allTests),
    testCase(ValidationComparableTests.allTests)
])
