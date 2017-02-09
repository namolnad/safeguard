//
//  TestLogger.swift
//  Safeguard
//
//  Created by Dan Loman on 2/9/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation
import Safeguard

class TestLogger: SafeLogger {
    var testString: String?

    private func setTestString(message: String) {
        testString = message
    }

    override func debug(message: @autoclosure @escaping () -> String) {
        setTestString(message: message())
    }

    override func warn(message: @autoclosure @escaping () -> String, properties: @autoclosure @escaping () -> [String : Any]?) {
        var propertiesString: String = ""

        if let properties = properties() {
            propertiesString = "\(properties)"
        }

        setTestString(message: "\(message()) with properties: \(propertiesString)")
    }
}
