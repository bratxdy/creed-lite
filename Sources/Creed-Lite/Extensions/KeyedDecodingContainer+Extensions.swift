//
//  KeyedDecodingContainer+Extensions.swift
//  
//
//  Created by Scott Petit on 3/20/23.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeLocalDate(forKey key: Key) throws -> Date {
        if let dateString = try? decode(String.self, forKey: key) {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Specify the format for the date string
            
            if let date = formatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(forKey: key,
                      in: self,
                      debugDescription: "Date string does not match decodeLocalDate format expected by formatter - \(dateString)")
            }
        } else {
            throw DecodingError.dataCorruptedError(forKey: key,
                  in: self,
                  debugDescription: "No Date provided")
        }
    }
    
    func decodeYearMonthDayDate(forKey key: Key) throws -> Date {
        if let dateString = try? decode(String.self, forKey: key) {
            if let date = DateFormatter.isoDate.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(forKey: key,
                      in: self,
                      debugDescription: "Date string does not match decodeYearMonthDayDate format expected by formatter - \(dateString)")
            }
        } else {
            throw DecodingError.dataCorruptedError(forKey: key,
                  in: self,
                  debugDescription: "No Date provided")
        }
    }

    func decodeYearMonthDayDates(forKey key: Key) throws -> [Date] {
        if let dateStrings = try? decode([String].self, forKey: key) {
            return dateStrings.compactMap { dateString -> Date? in
                DateFormatter.yearMonthDay.date(from: dateString)
            }
        } else {
            throw DecodingError.dataCorruptedError(forKey: key,
                  in: self,
                  debugDescription: "No Dates provided")
        }
    }

    func decodeISODate(forKey key: Key, with timeZone: TimeZone? = nil) throws -> Date {
        if let dateString = try? decode(String.self, forKey: key) {
            let formatter = ISO8601DateFormatter()
            if let timeZone {
                formatter.timeZone = timeZone
            }
            formatter.formatOptions.insert(.withFractionalSeconds)
            if let date = formatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(forKey: key,
                      in: self,
                      debugDescription: "Date string does not match decodeISODate format expected by formatter - \(dateString)")
            }
        } else {
            throw DecodingError.dataCorruptedError(forKey: key,
                  in: self,
                  debugDescription: "No Date provided")
        }
    }

    func decodeISO8601WithFractionalSeconds(forKey key: Key) throws -> Date {
        if let dateString = try? decode(String.self, forKey: key) {
            let formatter = DateFormatter.iso8601WithFractionalSeconds
            if let date = formatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(forKey: key,
                      in: self,
                      debugDescription: "Date string does not match decodeISO8601WithFractionalSeconds format expected by formatter - \(dateString)")
            }
        } else {
            throw DecodingError.dataCorruptedError(forKey: key,
                  in: self,
                  debugDescription: "No Date provided")
        }
    }
    
    func decodeSecondsSince1970(forKey key: Key) throws -> Date {
        if let seconds = try? decode(TimeInterval.self, forKey: key) {
            return Date(timeIntervalSince1970: seconds)
        } else {
            throw DecodingError.dataCorruptedError(forKey: key,
                  in: self,
                  debugDescription: "No Date provided")
        }
    }

}
