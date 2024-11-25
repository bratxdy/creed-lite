//
//  Logger+Extensions.swift
//
//
//  Created by Scott Petit on 9/12/23.
//

import Foundation
import OSLog

extension Logger {
    static let Creed = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.ladder.bootcamp", category: "Creed")
}
