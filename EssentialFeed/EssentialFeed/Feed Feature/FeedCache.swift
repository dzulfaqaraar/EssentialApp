//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 11/01/23.
//

import Foundation

public protocol FeedCache {
	func save(_ feed: [FeedImage]) throws
}
