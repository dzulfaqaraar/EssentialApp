//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 07/01/23.
//

import Foundation

public protocol FeedImageDataStore {
	func insert(_ data: Data, for url: URL) throws
	func retrieve(dataForURL url: URL) throws -> Data?
}
