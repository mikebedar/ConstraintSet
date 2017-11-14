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

public protocol ConstraintAnchorProvider: class {
	var topAnchor: NSLayoutYAxisAnchor { get }
	var bottomAnchor: NSLayoutYAxisAnchor { get }
	var leftAnchor: NSLayoutXAxisAnchor { get }
	var rightAnchor: NSLayoutXAxisAnchor { get }
	var centerXAnchor: NSLayoutXAxisAnchor { get }
	var centerYAnchor: NSLayoutYAxisAnchor { get }
	var widthAnchor: NSLayoutDimension { get }
	var heightAnchor: NSLayoutDimension { get }
	
}

extension UIView: ConstraintAnchorProvider {}
extension UILayoutGuide: ConstraintAnchorProvider {}


public extension UIView {
	/// Create anchor equality constraints from this view to the specified view or layout guide using selected edges
	/// - parameter view: The view or layout guide to use a secondItem in constraint creation
	/// - parameter edges: A description of which edges to create constraints for
	/// - parameter insets: UIEdgeInsets to define padding
	/// - parameter activate: If true, activate all constraints added
	/// - parameter priority: Priority to use for added constraints
	/// - parameter disableAutoMaskTranslation: If True, sets 'translatesAutoresizingMaskIntoConstraints' to false for this view
	/// - Returns: a ViewEdgeConstraintSet containing the created constraints
	@discardableResult
	public func pinEdges(to anchorProvider: ConstraintAnchorProvider, edges: ViewEdgeConstraintSet.EdgeType = .all, insets: UIEdgeInsets? = nil, activate: Bool = true, priority: UILayoutPriority = .defaultHigh, disableAutoMaskTranslation: Bool = true) -> ViewEdgeConstraintSet {
		
		let top = edges.contains(.top) ? topAnchor.constraint(equalTo: anchorProvider.topAnchor) : nil
		let bottom = edges.contains(.bottom) ? bottomAnchor.constraint(equalTo: anchorProvider.bottomAnchor) : nil
		let left = edges.contains(.left) ? leftAnchor.constraint(equalTo: anchorProvider.leftAnchor) : nil
		let right = edges.contains(.right) ? rightAnchor.constraint(equalTo: anchorProvider.rightAnchor) : nil
		
		if disableAutoMaskTranslation {
			translatesAutoresizingMaskIntoConstraints = false
		}
		let set = ViewEdgeConstraintSet(topConstraint: top, bottomConstraint: bottom, leftConstraint: left, rightConstraint: right, activate: false, priority: priority)
		if let insets = insets { set.setEdgeInsetConstants(insets: insets) }
		if activate { set.activateAllConstraints() }
		return set
	}
	
	/// Create anchor equality constraints from this view to the specified view
	/// - parameter view: The view or layout guide to constraint to
	/// - parameter insets: UIEdgeInsets to define padding
	/// - parameter activate: If true, activate all constraints added
	/// - parameter priority: Priority to use for added constraints
	/// - Returns: a ViewEdgeConstraintSet containing the created constraints
	@discardableResult
	public func pinEdges(to anchorProvider: ConstraintAnchorProvider, insets: UIEdgeInsets? = nil, activate: Bool = true, priority: UILayoutPriority = .defaultHigh) -> ViewEdgeConstraintSet {
		return self.pinEdges(to: anchorProvider, edges: .all, insets: insets, activate: activate, priority: priority)
	}
	
	/// Create anchor equality constraints from this view to it's superview, if one exists
	/// - parameter insets: UIEdgeInsets to define padding
	/// - parameter activate: If true, activate all constraints added
	/// - parameter priority: Priority to use for added constraints
	/// - Returns: a ViewEdgeConstraintSet containing the created constraints, or nil if no superview exists
	@discardableResult
	public func pinEdgesToSuperView(insets: UIEdgeInsets? = nil, activate: Bool = true, priority: UILayoutPriority = .defaultHigh) -> ViewEdgeConstraintSet? {
		guard let superview = superview else { return nil }
		return self.pinEdges(to: superview, insets: insets, activate: activate, priority: priority)
	}

	
}
