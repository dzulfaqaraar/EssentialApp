//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 17/12/22.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
	func deleteCachedFeed() throws
	func insert(_ feed: [LocalFeedImage], timestamp: Date) throws
	func retrieve() throws -> CachedFeed?
}
