//
//  File.swift
//  
//
//  Created by Andrew Hulsizer on 1/11/24.
//

import Foundation

extension UUID {
    var guid: String {
        let uuidString = self.uuidString.replacingOccurrences(of: "-", with: "")
        return String(uuidString[uuidString.index(uuidString.startIndex, offsetBy: 8)..<uuidString.endIndex])
    }
}

public struct AWSTraceID {
    public let version: Int
    public let time: Date
    public let id: String

    public init(version: Int = 1, time: Date = .now, uuid: UUID = UUID()) {
        self.version = version
        self.time = time
        self.id = uuid.guid
    }

    public var traceIDString: String {
        let time = String(format: "%02X", Int(time.timeIntervalSince1970))
        return "\(version)-\(time)-\(id)".lowercased()
    }
}
