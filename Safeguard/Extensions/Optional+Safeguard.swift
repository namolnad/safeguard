//
//  Optional+Safeguard.swift
//  Safeguard
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

extension Optional {
    /// safeguard() passes information to your application's logger if an unexpected nil value is encountered
    ///
    /// - Parameters:
    ///   - label: An unrequired label to provide custom messaging or variable name, if desired
    ///   - file: The file where the nil variable is located
    ///   - caller: The location/calling function where the nil variable is located
    ///   - line: The line #  where the nil variable is located
    /// - Returns: The unaltered Optional value
    public func safeguard(_ label: String? = nil, file: String = #file, caller: String = #function, line: Int = #line) -> Optional {
        if case .none = self {
            let type: Wrapped.Type = Wrapped.self
            let fileName: String = URL(fileURLWithPath: file).lastPathComponent
            let defaultMessage: String = "Unexpected nil value for \(type) type"

            var message: String = defaultMessage

            if let label = label {
                message = "\(label) | \(defaultMessage)"
            }

            var params: [String: Any] = [
                "failed_unwrap_type": type,
                "file": fileName,
                "called_from": caller,
                "line": line
            ]

            if let customParams = Safeguard.instance.customLoggingParams {
                params += customParams
            }

            let safeguardLogger: SafeLoggable? = Safeguard.instance.logger

            var isDebug = false

            #if DEBUG
                safeguardLogger?.debug(message: "\(message) with params: \(params)")
                isDebug = true
            #else
                safeguardLogger?.warn(message: message, properties: params)
            #endif

            Safeguard.instance.nilHandler?(isDebug)
        }
        return self
    }
}
