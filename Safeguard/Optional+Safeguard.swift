//
//  Optional+Safeguard.swift
//  Safeguard
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

extension Optional {
    public func safeguard(file: String = #file, caller: String = #function, line: Int = #line) -> Optional {
        if self == nil {
            let type: Wrapped.Type = Wrapped.self
            let fileName: String = URL(fileURLWithPath: file).lastPathComponent
            let message: String = "Guard failed with type: \(type)"

            var params: [String: Any] = [
                "failed_unwrap_type": type,
                "file": fileName,
                "called_from": caller,
                "line": line
            ]

            if let customParams = Safeguard.instance.customLoggingParams {
                params += customParams
            }

            let safeguardLogger: SafeLogger? = Safeguard.instance.logger

            var isDebug = false

            #if DEBUG
                safeguardLogger?.debug("\(message) and params: \(params)")
                isDebug = true
            #else
                safeguardLogger?.warn(message: message, properties: params)
            #endif

            Safeguard.instance.nilHandler?(isDebug)
        }
        return self
    }
}
