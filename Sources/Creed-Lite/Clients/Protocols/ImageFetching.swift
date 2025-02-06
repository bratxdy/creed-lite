//
//  ImageFetching.swift
//  Creed-Lite
//
//  Created by Brady Miller on 2/5/25.
//

import UIKit

public protocol ImageFetching {
    func fetchImage(url: URL) async throws -> UIImage
}
