//
//  ImageFetcher.swift
//  Creed-Lite
//
//  Created by Brady Miller on 2/5/25.
//

import SwiftUI

public struct ImageError: Error {
    public init() { }
}

public class ImageFetcher: ImageFetching {
    let imageCache: Cachable
    let session: URLSession
    
    public init(imageCache: Cachable, session: URLSession) {
        self.imageCache = imageCache
        self.session = session
    }
    
    public func fetchImage(url: URL) async throws -> UIImage {
        let urlRequest = URLRequest(url: url)
        
        if let cachedImage = imageCache.cachedImage(for: urlRequest) {
            return cachedImage
        } else {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw ImageError() }
            
            guard 200..<300 ~= httpResponse.statusCode else { throw ImageError() }
            
            guard let uiImage = UIImage(data: data) else { throw ImageError() }
            
            let cachedResponse = CachedURLResponse(response: response, data: data)
            imageCache.storeCachedResponse(cachedResponse, for: urlRequest)
            
            return uiImage
        }
    }
}
