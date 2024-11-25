//
//  Store.swift
//  Creed
//
//  Created by Andrew Hulsizer on 11/20/24.
//

import Foundation

public protocol Store {
    associatedtype Model

    func update(_ model: Model) throws
}
