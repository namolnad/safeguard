//
//  Dictionary+Safeguard.swift
//  Safeguard
//
//  Created by Dan Loman on 2/3/17.
//  Copyright © 2017 Dan Loman. All rights reserved.
//

import Foundation

func += <K, V> (left: inout [K: V], right: [K: V]?) {
    guard let right = right else { return }
    right.forEach { left.updateValue($1, forKey: $0) }
}
