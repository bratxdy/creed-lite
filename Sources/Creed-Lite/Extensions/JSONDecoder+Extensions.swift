//
//  JSONDecoder+Extensions.swift
//  
//
//  Created by Scott Petit on 2/26/23.
//

import Foundation

// inspired by https://gist.github.com/Ikloo/e0011c99665dff0dd8c4d116150f9129
extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()

        if let stringValue = try? container.decode(String.self) {
            // todo clean up and attempt to make static
            let formatter1 = ISO8601DateFormatter()
            formatter1.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let formatter2 = ISO8601DateFormatter()
            formatter2.formatOptions = [.withInternetDateTime]

            func parseISO8601Timestamp(from iso8601TimestampStr: String) -> Date? {
                (formatter1.date(from: iso8601TimestampStr) ?? formatter2.date(from: iso8601TimestampStr))
            }
            
            if let date = parseISO8601Timestamp(from: stringValue) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: " + stringValue)
            }
        } else if let timeIntervalValue = try? container.decode(TimeInterval.self) {
            return Date(timeIntervalSince1970: timeIntervalValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date value")
        }
    }
}

extension JSONDecoder {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
        return decoder
    }
}
