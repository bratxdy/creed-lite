//
//  Safe.swift
//
//
//  Created by Andrew Hulsizer on 6/7/22.
//

import Foundation
import OSLog

public struct Safe<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch let error {
            Logger.Creed.error("Failed Decoding Safe value with \(error.localizedDescription)")
            self.value = nil
        }
    }
}
