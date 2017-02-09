//
//  Safeguard.swift
//  Safeguard
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

public protocol SafeLoggable {
    func debug(message: @autoclosure @escaping () -> String)
    func warn(message: @autoclosure @escaping () -> String, properties: @autoclosure @escaping () -> [String: Any]?)
}

public class Safeguard {
    static let instance: Safeguard = Safeguard()

    var nilHandler: ((Bool) -> Void)?

    var logger: SafeLoggable?

    var customLoggingParams: [String: Any]?

    // Note: - Passing nil to a parameter will not modify setting
    public static func configure(logger: SafeLoggable? = nil, customLoggingParams: [String: Any]? = nil, nilHandler: ((Bool) -> Void)? = nil) {
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
