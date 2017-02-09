//
//  SafeguardTests.swift
//  SafeguardTests
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import XCTest
@testable import Safeguard

class SafeguardTests: XCTestCase {
    var emptyOptional: String?
    var safeOptional: String?
    var nilHandledString: String?

    let testLogger = TestLogger()

    override func setUp() {
        super.setUp()
        emptyOptional = nil
        safeOptional = "safe"
        nilHandledString = nil

        Safeguard.configure(logger: testLogger, customLoggingParams: ["safe": "guard"], nilHandler: { [weak self] isDebug in
            if isDebug {
                self?.nilHandledString = "notNil"
            } else {
                self?.nilHandledString = ""
            }

            self?.nilHandledString = (self?.nilHandledString)! + "Safeguard"
        })
    }

    override func tearDown() {
        super.tearDown()
        testLogger.testString = nil
    }

    func testNilOptional() {
        if let _ = emptyOptional.safeguard() {} // Continue

        XCTAssertEqual(testLogger.testString, "Guard failed with type: String and params: [\"failed_unwrap_type\": Swift.String, \"file\": \"SafeguardTests.swift\", \"safe\": \"guard\", \"called_from\": \"testNilOptional()\", \"line\": 42]")
        XCTAssertEqual(nilHandledString, "notNilSafeguard")
    }

    func testNonNilOptional() {
        if let _ = safeOptional.safeguard() {} // Continue

        XCTAssertNil(testLogger.testString)
        XCTAssertNil(nilHandledString)
    }
}
