//
//  Logger.swift
//  safeguard
//
//  Created by Dan Loman on 1/13/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

struct Logger {
    enum LogLevel {
        case debug
        case warn
    }

    private func log(withLevel level: LogLevel, message: String, properties: [String: Any]?) {
        let params: String = properties?.description ?? "nil"

        switch level {
        default:
            print("\(message) and params: \(params)")
        }
    }

    func warn(message: String, properties: [String: Any]?) {
        log(withLevel: .warn, message: message, properties: properties)
    }

    func debug(message: String, properties: [String: Any]?) {
        log(withLevel: .debug, message: message, properties: properties)
    }
}

let log: Logger = {
    return Logger()
}()
