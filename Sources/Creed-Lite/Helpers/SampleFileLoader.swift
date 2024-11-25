//
//  SampleFileLoader.swift
//  
//
//  Created by Scott Petit on 3/24/23.
//

import Foundation

func loadJSONFile<T: Decodable>(named fileName: String, type: T.Type) throws -> T {
    if let fileURL = Bundle.module.url(forResource: fileName, withExtension: "json") {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    } else {
        let error = URLError(.fileDoesNotExist)
        throw APIError(error: error)
    }
}
