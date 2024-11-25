//
//  Either.swift
//  
//
//  Created by Scott Petit on 2/28/23.
//

import Foundation

public enum Either<Left, Right> {
    case left(Left)
    case right(Right)

    public var leftValue: Left? {
        switch self {
        case let .left(value):
            return value
        case .right:
            return nil
        }
    }

    public var rightValue: Right? {
        switch self {
        case .left:
            return nil
        case let .right(value):
            return value
        }
    }
}

extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Sendable where Left: Sendable, Right: Sendable {}
extension Either: Decodable where Left: Decodable, Right: Decodable {}
