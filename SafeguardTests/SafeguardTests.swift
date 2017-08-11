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

    var expectedLabel: String {
        return "emptyOptional | "
    }

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

        XCTAssertEqual(testLogger.testString, expectedNonLabelString(functionName: "testNilOptional()",lineNumber: "46"))
        XCTAssertEqual(nilHandledString, "notNilSafeguard")
    }

    func testNonNilOptional() {
        if let _ = safeOptional.safeguard() {} // Continue

        XCTAssertNil(testLogger.testString)
        XCTAssertNil(nilHandledString)
    }

    func testCustomLabel() {
        if let _ = emptyOptional.safeguard("emptyOptional") {} // Continue

        XCTAssertEqual(testLogger.testString, expectedLabel + expectedNonLabelString(functionName: "testCustomLabel()", lineNumber: "60"))
        XCTAssertEqual(nilHandledString, "notNilSafeguard")
    }

    func expectedNonLabelString(functionName: String, lineNumber: String) -> String {
        return "Unexpected nil value for String type with params: [\"failed_unwrap_type\": Swift.String, \"file\": \"SafeguardTests.swift\", \"safe\": \"guard\", \"called_from\": \"\(functionName)\", \"line\": \(lineNumber)]"
    }
}
