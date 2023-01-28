//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 11/01/23.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
