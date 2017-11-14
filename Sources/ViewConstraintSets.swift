//    MIT License
//
//    Copyright (c) 2017 Michael C. Bedar <mike@bedar.net>
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import UIKit

public class ViewConstraints {
	public var edgeConstraints: ViewEdgeConstraintSet?
	public var dimensionalConstraints: ViewDimensionalConstraintSet?
	public var centeringConstraints: ViewCenteringConstraintSet?
}

public class ViewDimensionalConstraintSet: ConstraintSet {
    public var widthConstraint: NSLayoutConstraint?
    public var heightConstraint: NSLayoutConstraint?
	
	public func setSizeConstants(size: CGSize) {
		setSizeConstants(width: size.width, height: size.height)
	}
	
	public func setSizeConstants(width: CGFloat?, height: CGFloat?) {
		if let width = width { widthConstraint?.constant = width }
		if let height = height { heightConstraint?.constant = height }
	}
    
    public init(widthConstraint: NSLayoutConstraint?, heightConstraint: NSLayoutConstraint?, activate: Bool = true, priority: UILayoutPriority = .defaultHigh) {
        self.widthConstraint = widthConstraint
        self.heightConstraint = heightConstraint
        super.init(constraints: [widthConstraint, heightConstraint].flatMap({$0}) , activate: activate)
    }
}

public class ViewCenteringConstraintSet: ConstraintSet {
    public var centerXConstraint: NSLayoutConstraint?
    public var centerYConstraint: NSLayoutConstraint?
	
	public func setOffsetConstants(dx: CGFloat?, dy: CGFloat?) {
		if let dx = dx { centerXConstraint?.constant = dx }
		if let dy = dy { centerYConstraint?.constant = dy }
	}
	
	public func clearOffsetConstants() {
		centerXConstraint?.constant = 0
		centerYConstraint?.constant = 0
	}
    
    public init(centerXConstraint: NSLayoutConstraint?, centerYConstraint: NSLayoutConstraint?, activate: Bool = true, priority: UILayoutPriority = .defaultHigh) {
        self.centerXConstraint = centerXConstraint
        self.centerYConstraint = centerYConstraint
        super.init(constraints: [centerXConstraint, centerYConstraint].flatMap({$0}) , activate: activate)
    }
}

public class ViewEdgeConstraintSet: ConstraintSet {
	public struct EdgeType: OptionSet {
		public let rawValue: Int
		public static let left = EdgeType(rawValue: 1 << 0)
		public static let right = EdgeType(rawValue: 1 << 1)
		public static let top = EdgeType(rawValue: 1 << 2)
		public static let bottom = EdgeType(rawValue: 1 << 3)
		public static let all: EdgeType = [.left, .right, .top, .bottom]
		public static let topAndBottom: EdgeType = [.top, .bottom]
		public static let leftAndRight: EdgeType = [.left, .right]
		public static let allExceptBottom: EdgeType = [.top, .leftAndRight]
		public static let allExceptTop: EdgeType = [.bottom, .leftAndRight]
		public static let allExceptLeft: EdgeType = [.right, .topAndBottom]
		public static let allExceptRight: EdgeType = [.left, .topAndBottom]
		
		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
	}
	
    public var topConstraint: NSLayoutConstraint?
    public var bottomConstraint: NSLayoutConstraint?
    public var leftConstraint: NSLayoutConstraint?
    public var rightConstraint: NSLayoutConstraint?

    public init(topConstraint: NSLayoutConstraint?, bottomConstraint: NSLayoutConstraint?, leftConstraint: NSLayoutConstraint?, rightConstraint: NSLayoutConstraint?, activate: Bool = true, priority: UILayoutPriority =  .defaultHigh) {
		self.topConstraint = topConstraint
		self.bottomConstraint = bottomConstraint
		self.leftConstraint = leftConstraint
		self.rightConstraint = rightConstraint
		super.init(constraints: [topConstraint, bottomConstraint, leftConstraint, rightConstraint].flatMap({$0}), activate: activate)
    }
	
	public func setMarginConstants(margin: CGFloat) {
		setEdgeInsetConstants(insets: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
	}
	
	public func setEdgeInsetConstants(insets: UIEdgeInsets) {
		topConstraint?.constant = insets.top
		bottomConstraint?.constant = -insets.bottom
		leftConstraint?.constant = insets.left
		rightConstraint?.constant = -insets.right
	}
}


