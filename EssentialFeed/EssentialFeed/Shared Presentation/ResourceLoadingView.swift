//
//  ResourceLoadingView.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 21/01/23.
//

import Foundation

public protocol ResourceLoadingView {
	func display(_ viewModel: ResourceLoadingViewModel)
}

public struct ResourceLoadingViewModel {
	public let isLoading: Bool
}
