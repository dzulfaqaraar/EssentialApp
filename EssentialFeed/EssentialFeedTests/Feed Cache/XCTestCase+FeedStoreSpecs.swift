//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Dzulfaqar on 17/12/22.
//

import XCTest
import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {
	func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		expect(sut, toRetrieve: .success(.none), file: file, line: line)
	}

	func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		expect(sut, toRetrieveTwice: .success(.none), file: file, line: line)
	}

	func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		let feed = uniqueImageFeed().local
		let timestamp = Date()

		insert((feed, timestamp), to: sut)

		expect(sut, toRetrieve: .success(CachedFeed(feed: feed, timestamp: timestamp)))
	}

	func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		let feed = uniqueImageFeed().local
		let timestamp = Date()

		insert((feed, timestamp), to: sut)

		expect(sut, toRetrieveTwice: .success(CachedFeed(feed: feed, timestamp: timestamp)))
	}

	func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		let feed = uniqueImageFeed().local
		let timestamp = Date()

		insert((feed, timestamp), to: sut)

		expect(sut, toRetrieve: .success(CachedFeed(feed: feed, timestamp: timestamp)))
	}

	func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		let feed = uniqueImageFeed().local
		let timestamp = Date()

		insert((feed, timestamp), to: sut)
		insert((feed, timestamp), to: sut)

		expect(sut, toRetrieve: .success(CachedFeed(feed: feed, timestamp: timestamp)))
	}

	func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)

		let latestFeed = uniqueImageFeed().local
		let latestTimestamp = Date()
		insert((latestFeed, latestTimestamp), to: sut)

		expect(sut, toRetrieve: .success(CachedFeed(feed: latestFeed, timestamp: latestTimestamp)))
	}

	func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		let deletionError = deleteCache(from: sut)

		XCTAssertNil(deletionError, "Expected empty cache deletion to succeed")
	}

	func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		deleteCache(from: sut)

		expect(sut, toRetrieve: .success(.none))
	}

	func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)

		let deletionError = deleteCache(from: sut)

		XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed")
	}

	func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)

		deleteCache(from: sut)

		expect(sut, toRetrieve: .success(.none))
	}

	@discardableResult
	func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
		do {
			try sut.insert(cache.feed, timestamp: cache.timestamp)
			return nil
		} catch {
			return error
		}
	}

	@discardableResult
	func deleteCache(from sut: FeedStore) -> Error? {
		do {
			try sut.deleteCachedFeed()
			return nil
		} catch {
			return error
		}
	}

	func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: Result<CachedFeed?, Error>, file: StaticString = #filePath, line: UInt = #line) {
		expect(sut, toRetrieve: expectedResult, file: file, line: line)
		expect(sut, toRetrieve: expectedResult, file: file, line: line)
	}

	func expect(_ sut: FeedStore, toRetrieve expectedResult: Result<CachedFeed?, Error>, file: StaticString = #filePath, line: UInt = #line) {
		let retrievedResult = Result { try sut.retrieve() }
		switch (expectedResult, retrievedResult) {
		case (.success(.none), .success(.none)),
		     (.failure, .failure):
			break

		case let (.success(.some((expectedFeed, expectedTimestamp))), .success(.some((retrievedFeed, retrievedTimestamp)))):
			XCTAssertEqual(retrievedFeed, expectedFeed, file: file, line: line)
			XCTAssertEqual(retrievedTimestamp, expectedTimestamp, file: file, line: line)

		default:
			XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
		}
	}
}
