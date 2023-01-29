//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Dzulfaqar on 23/12/22.
//

import UIKit

extension UIButton {
	func simulateTap() {
		simulate(event: .touchUpInside)
	}
}
