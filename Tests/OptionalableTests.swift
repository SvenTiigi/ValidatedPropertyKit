//
//  OptionalableTests.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 22.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class OptionalableTests: XCTestCase {
    
    static var allTests = [
        ("testOptionalWrapped", testOptionalWrapped)
    ]

    func testOptionalWrapped() {
        var optionalString: String? = nil
        XCTAssertNil(optionalString.wrapped)
        optionalString = UUID().uuidString
        XCTAssertNotNil(optionalString.wrapped)
        optionalString = nil
        XCTAssertNil(optionalString.wrapped)
    }

}
