//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Dzulfaqar on 15/01/23.
//

import UIKit

extension UIView {
	func enforceLayoutCycle() {
		layoutIfNeeded()
		RunLoop.current.run(until: Date())
	}
}
