//
//  File.swift
//  
//
//  Created by Andrew Hulsizer on 6/13/24.
//

import Foundation

@propertyWrapper
public struct JSONFile<T> where T: Decodable {
    private let fileName: String
    private let bundle: Bundle
    
    public var wrappedValue: T {
        guard let result = loadJson(fileName: fileName) else {
            fatalError("Cannot load json data \(fileName)")
        }
        return result
    }

    public init(_ fileName: String, bundle: Bundle = .main) {
        self.fileName = fileName
        self.bundle = bundle
    }

    public func loadJson(fileName: String) -> T? {
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let result = try? JSONDecoder().decode(T.self, from: data)
        else {
            return nil
        }
        return result
    }
}
