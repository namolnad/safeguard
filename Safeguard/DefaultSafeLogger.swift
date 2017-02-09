//
//  DefaultSafeLogger.swift
//  Safeguard
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

class DefaultSafeLogger: SafeLogger {
    func debug(message: @autoclosure @escaping () -> String) {
        logToConsole(message: message())
    }

    func warn(message: @autoclosure @escaping () -> String, properties: @autoclosure @escaping () -> [String : Any]?) {
        var propertiesString: String = ""

        if let properties = properties() {
            propertiesString = "\(properties)"
        }

        logToConsole(message: "\(message()) with properties: \(propertiesString)")
    }

    func logToConsole(message: String) {
        print(message)
    }
}
