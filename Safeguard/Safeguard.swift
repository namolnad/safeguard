//
//  Safeguard.swift
//  Safeguard
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

public protocol SafeLogger {
    func debug(_ message: @autoclosure @escaping () -> String)
    func warn(message: @autoclosure @escaping () -> String, properties: @autoclosure @escaping () -> [String: Any]?)
}

public class Safeguard {
    public static let instance: Safeguard = Safeguard()

    public var nilHandler: ((Bool) -> Void)?

    public var logger: SafeLogger? = DefaultSafeLogger()

    public var customLoggingParams: [String: Any]?

    public static func configure(logger: SafeLogger? = nil, customLoggingParams: [String: Any]? = nil, nilHandler: ((Bool) -> Void)? = nil) {
        if let logger = logger {
            instance.logger = logger
        }

        if let customLoggingParams = customLoggingParams {
            instance.customLoggingParams = customLoggingParams
        }

        if let nilHandler = nilHandler {
            instance.nilHandler = nilHandler
        }
    }
}
