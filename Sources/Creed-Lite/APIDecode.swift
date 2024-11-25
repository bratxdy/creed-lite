//
//  APIDecode.swift
//  
//
//  Created by Scott Petit on 2/26/23.
//

import Foundation

public func apiDecode<A: Decodable>(_ type: A.Type, from data: Data) throws -> A {
    let decoder = JSONDecoder.decoder
    do {
        return try decoder.decode(A.self, from: data)
    } catch let decodingError {
        throw decodingError
    }
}
