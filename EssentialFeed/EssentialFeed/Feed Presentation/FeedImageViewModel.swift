//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 27/12/22.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
