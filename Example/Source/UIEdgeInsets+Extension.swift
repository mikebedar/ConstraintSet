//
//  UIEdgeInsets+Extension.swift
//  ConstraintSetExample
//
//  Created by Michael Bedar on 11/14/17.
//  Copyright © 2017 Michael Bedar. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
	init(constant: CGFloat) {
		self = UIEdgeInsets(top: constant, left: constant, bottom: constant, right: constant)
	}
}
