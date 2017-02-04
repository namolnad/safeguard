//
//  SafeguardTests.swift
//  SafeguardTests
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import XCTest
import Safeguard

class SafeguardTests: XCTestCase {
    var emptyOptional: String?
    var safeOptional: String?

    let testLogger = TestLogger()

    override func setUp() {
        super.setUp()
        emptyOptional = nil
        safeOptional = "safe"

        Safeguard.configure(logger: testLogger)
    }

    override func tearDown() {
        super.tearDown()
        testLogger.testString = nil
    }

    func testNilOptional() {
        if let _ = emptyOptional.safeguard() {} // Continue

        XCTAssertNotNil(testLogger.testString)
    }

    func testNonNilOptional() {
        if let _ = safeOptional.safeguard() {} // Continue

        XCTAssertNil(testLogger.testString)
    }

}

class TestLogger: SafeLogger {
    var testString: String?

    func setTestString(message: String) {
        testString = message
    }

    func debug(_ message: @autoclosure @escaping () -> String) {
        setTestString(message: message())
    }

    func warn(message: @autoclosure @escaping () -> String, properties: @autoclosure @escaping () -> [String : Any]?) {
        var propertiesString: String = ""

        if let properties = properties() {
            propertiesString = "\(properties)"
        }

        setTestString(message: "\(message()) with properties: \(propertiesString)")
    }
}
