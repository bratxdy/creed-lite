//
//  OrderedBag.swift
//  LadderBootcamp
//
//  Created by Andrew Hulsizer on 5/12/20.
//  Copyright © 2020 Ladder. All rights reserved.
//

import Foundation

public struct OrderedBag<T: Hashable>: Hashable, Sendable where T : Sendable {
    private var storage: [T: UInt] = [:]
    private var order: [T] = []

    public private(set) var count: UInt = 0

    public init() {}

    public init<C: Collection>(_ collection: C) where C.Element == T {
        for element in collection {
            add(element)
        }
    }

    public mutating func add(_ elem: T) {
        if storage[elem] == nil {
            order.append(elem)
        }
        storage[elem, default: 0] += 1
        count += 1
    }

    public mutating func remove(_ elem: T) {
        if let currentCount = storage[elem] {
            if currentCount > 1 {
                storage[elem] = currentCount - 1
            } else {
                storage.removeValue(forKey: elem)
            }
            count -= 1
        }
    }

    public func isSubBag(of superbag: OrderedBag<T>) -> Bool {
        for (key, count) in storage {
            let superbagcount = superbag.storage[key] ?? 0
            if count > superbagcount {
                return false
            }
        }
        return true
    }

    public func count(for key: T) -> UInt {
        return storage[key] ?? 0
    }

    public var allItems: [T] {
        var result = [T]()
        for (key, count) in storage {
            for _ in 0 ..< count {
                result.append(key)
            }
        }
        return result
    }

    public var bags: [T] {
        var result = [T]()
        for (key, _) in storage {
            result.append(key)
        }
        return result
    }

    public var allBagsAndCounts: [(T, UInt)] {
        order.map { item -> (T, UInt) in
            (item, self.count(for: item))
        }
    }
}

// MARK: - Equatable

extension OrderedBag: Equatable {
    public static func == (lhs: OrderedBag<T>, rhs: OrderedBag<T>) -> Bool {
        if lhs.storage.count != rhs.storage.count {
            return false
        }
        for (lkey, lcount) in lhs.storage {
            let rcount = rhs.storage[lkey] ?? 0
            if lcount != rcount {
                return false
            }
        }
        return true
    }
}

// MARK: - ExpressibleByArrayLiteral

extension OrderedBag: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}
