//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Dzulfaqar on 21/12/22.
//

import Foundation

public protocol FeedImageDataLoader {
	func loadImageData(from url: URL) throws -> Data
}
