//
//  FeedLocalizationTests.swift
//  EssentialFeediOSTests
//
//  Created by Dzulfaqar on 22/12/22.
//

import XCTest
import EssentialFeed

final class FeedLocalizationTests: XCTestCase {
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "Feed"
		let bundle = Bundle(for: FeedPresenter.self)

		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
}
