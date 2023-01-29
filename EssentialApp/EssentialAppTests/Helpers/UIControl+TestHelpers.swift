//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Dzulfaqar on 23/12/22.
//

import UIKit

extension UIControl {
	func simulate(event: UIControl.Event) {
		allTargets.forEach { target in
			actions(forTarget: target, forControlEvent: event)?.forEach {
				(target as NSObject).perform(Selector($0))
			}
		}
	}
}
