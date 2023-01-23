//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Dzulfaqar on 26/12/22.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
