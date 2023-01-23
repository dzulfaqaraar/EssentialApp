//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeedTests
//
//  Created by Dzulfaqar on 31/12/22.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
