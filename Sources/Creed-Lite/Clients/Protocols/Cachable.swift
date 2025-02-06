//
//  Cachable.swift
//  Creed-Lite
//
//  Created by Brady Miller on 2/5/25.
//

import UIKit

public protocol Cachable {
    func cachedImage(for request: URLRequest) -> UIImage?
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest)
}
