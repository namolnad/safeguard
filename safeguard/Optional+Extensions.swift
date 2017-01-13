//
//  Optional+Extensions.swift
//  safeguard
//
//  Created by Dan Loman on 1/13/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

extension Optional {
    func safeguard(file: String = #file, caller: String = #function, line: Int = #line) -> Optional {
        if self == nil {
            let type: Wrapped.Type = Wrapped.self
            let fileName: String = URL(fileURLWithPath: file).lastPathComponent
            let message: String = "Guard failed with type: \(type)"

            let params: [String: Any] = [
                "failed_unwrap_type": type,
                "file": fileName,
                "called_from": caller,
                "line": line
            ]

            #if DEBUG
                log.debug(message: message, properties: params)
                assertionFailure()
            #else
                log.warn(message: message, properties: params)
            #endif
        }
        return self
    }
}
