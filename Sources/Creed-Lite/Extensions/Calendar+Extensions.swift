//
//  Calendar+Extensions.swift
//  LadderBootcamp
//
//  Created by Andrew Hulsizer on 8/17/21.
//  Copyright © 2021 Ladder. All rights reserved.
//

import Foundation

extension Calendar {
    public func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day!
    }
}
