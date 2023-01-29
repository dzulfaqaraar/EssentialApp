//
//  ResourceErrorView.swift
//  EssentialFeed
//
//  Created by Dzulfaqar on 21/01/23.
//

import Foundation

public struct ResourceErrorViewModel {
	public let message: String?

	static var noError: ResourceErrorViewModel {
		return ResourceErrorViewModel(message: nil)
	}

	static func error(message: String) -> ResourceErrorViewModel {
		return ResourceErrorViewModel(message: message)
	}
}

public protocol ResourceErrorView {
	func display(_ viewModel: ResourceErrorViewModel)
}
