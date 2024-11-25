//
//  Date+Extensions.swift
//  LadderBootcamp
//
//  Created by Andrew Hulsizer on 6/1/20.
//  Copyright © 2020 Ladder. All rights reserved.
//
import CoreGraphics
import Foundation

public extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
    
    static let utc: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()
    
    static let ladderUTC: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()
    
    static let ladder: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.timeZone = TimeZone.current
        return calendar
    }()
}

public extension Date {
    func dayOfTheWeek() -> String? {
        let day = Calendar.ladder.component(.weekday, from: self)
        switch day {
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        case 7: return "Saturday"
        default: return nil
        }
    }
    
    func minutesBetweenDates(_ newDate: Date?) -> CGFloat {
        guard let newDate = newDate else {
            return 0
        }
        
        // get both times sinces refrenced date and divide by 60 to get minutes
        let newDateMinutes = newDate.timeIntervalSinceReferenceDate / 60
        let oldDateMinutes = timeIntervalSinceReferenceDate / 60
        
        // then return the difference
        return abs(CGFloat(newDateMinutes - oldDateMinutes))
    }
    
    static var highPercisionTimeInterval: UInt64 {
        return UInt64(Date().timeIntervalSince1970 * 10_000_000)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.ladder) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.ladder) -> Int {
        return calendar.component(component, from: self)
    }
    
    func abbreviatedFormat(to date: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        
        return formatter.string(from: timeIntervalSince1970 - date.timeIntervalSince1970)!
    }
    
    func abbreviatedFormat(from date: Date) -> String {
        return date.abbreviatedFormat(to: self)
    }
}

public extension Date {
    static func today() -> Date {
        return Date()
    }
    
    static func tomorrow() -> Date {
        Calendar.ladder.date(byAdding: .day, value: 1, to: today())!
    }
    
    func next(_ weekday: Weekday, in calendar: Calendar = Calendar(identifier: .gregorian), considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   in: calendar,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, in calendar: Calendar = Calendar(identifier: .gregorian), considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   in: calendar,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             in calendar: Calendar = Calendar(identifier: .gregorian),
             considerToday consider: Bool = false) -> Date
    {
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
    func startOfDay() -> Date {
        return Calendar.ladder.startOfDay(for: self)
    }
}

public enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

// MARK: Helper methods

public extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        public var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}

public struct DateUnit {
    public enum Unit {
        case hour
        case day
        case month
        case year
    }
    
    public var amount: Int
    public var unit: Unit
}

public extension Date {
    func previous(_ units: DateUnit...) -> Date? {
        let units = units.map {
            var newUnit = $0
            newUnit.amount *= -1
            return newUnit
        }
        
        return moveDate(units)
    }
    
    func next(_ units: DateUnit...) -> Date? {
        return moveDate(units)
    }
    
    private func moveDate(_ units: [DateUnit]) -> Date? {
        var hoursToAdd = 0
        var monthsToAdd = 0
        var daysToAdd = 0
        var yearsToAdd = 0
        let currentDate = self
        
        for unit in units {
            switch unit.unit {
            case .hour: hoursToAdd += unit.amount
            case .month: monthsToAdd += unit.amount
            case .day: daysToAdd += unit.amount
            case .year: yearsToAdd += unit.amount
            }
        }
        
        var dateComponent = DateComponents()
        
        dateComponent.hour = hoursToAdd
        dateComponent.month = monthsToAdd
        dateComponent.day = daysToAdd
        dateComponent.year = yearsToAdd
        
        return Calendar.ladder.date(byAdding: dateComponent, to: currentDate)
    }
}

public extension Int {
    var hours: DateUnit {
        return DateUnit(amount: self, unit: .hour)
    }
    
    var months: DateUnit {
        return DateUnit(amount: self, unit: .month)
    }
    
    var days: DateUnit {
        return DateUnit(amount: self, unit: .day)
    }
    
    var years: DateUnit {
        return DateUnit(amount: self, unit: .year)
    }
}

public extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.ladder.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func allDates(till endDate: Date) -> [Date] {
        return Date.dates(from: self, to: endDate)
    }
}

public extension Date {
    
    func isDateMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let weekday = calendar.dateComponents([.weekday], from: self).weekday
        return weekday == 2
    }
}

public extension Date {
    
    init?(isoDate: String) {
        
        let dateFormatter = DateFormatter.isoDate
        // Convert String to Date
        if let date = dateFormatter.date(from: isoDate) {
            self = date
        } else {
            return nil
        }
    }
    
    init?(isoLocalDateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // Convert String to Date
        if let date = dateFormatter.date(from: isoLocalDateTime) {
            self = date
        } else {
            return nil
        }
    }
    
    init?(iso8601DateTime: String) {
        
        let dateFormatter = ISO8601DateFormatter()
        // Convert String to Date
        if let date = dateFormatter.date(from: iso8601DateTime) {
            self = date
        } else {
            return nil
        }
    }
    
    init?(iso8601DateTimeFractionalSeconds: String) {
        
        let dateFormatter = DateFormatter.iso8601WithFractionalSeconds
        // Convert String to Date
        if let date = dateFormatter.date(from: iso8601DateTimeFractionalSeconds) {
            self = date
        } else {
            return nil
        }
    }
}

extension Date {
    func toLocal() -> Date {
        var components = DateComponents()
        components.timeZone = .current
        
        let calendar = Calendar.utc
        
        components.year = calendar.component(.year, from: self)
        components.month = calendar.component(.month, from: self)
        components.day = calendar.component(.day, from: self)
        
        if let localDate = Calendar.ladder.date(from: components) {
            return localDate
        } else {
            return self
        }
    }
}
