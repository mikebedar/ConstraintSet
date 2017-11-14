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

public class ConstraintSet {
    public struct ItemOrderFilterOptions: OptionSet {
        public let rawValue: Int
        public static let first = ItemOrderFilterOptions(rawValue: 1 << 0)
        public static let second = ItemOrderFilterOptions(rawValue: 1 << 1)
        public static let all: ItemOrderFilterOptions = [.first, .second]
		
		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
    }
    
    private(set) var constraints: Set<NSLayoutConstraint>
	public var inactiveConstraints: [NSLayoutConstraint] { return constraints.filter{ !$0.isActive }}
	public var activeConstraints: [NSLayoutConstraint] { return constraints.filter{ $0.isActive }}
    
    public init(constraints: [NSLayoutConstraint]? = nil, activate: Bool = true) {
        self.constraints = Set(constraints ?? [])
        if activate { activateAllConstraints() }
    }
    
    /// Adds an existing constraint to the set
    @discardableResult
    public func addConstraint(_ constraint: NSLayoutConstraint) -> Bool {
        return constraints.insert(constraint).inserted
    }
    
    /// Adds multiple constraints to the set
    public func addConstraints(_ constraints: [NSLayoutConstraint]) {
        return constraints.forEach { self.constraints.insert($0) }
    }
    
    /// Activates all *inactive* constraints
    public func activateAllConstraints() {
        NSLayoutConstraint.activate(inactiveConstraints)
    }
    
    /// Deactivates all *active* constraints
    public func deactivateAllConstraints() {
        NSLayoutConstraint.deactivate(activeConstraints)
    }
    
    /// Sets the *constant* value of every constraint
    public func setConstant(value: CGFloat) {
        constraints.forEach({ $0.constant = value })
    }
    
    /// Sets the *priority* value of every constraint
    public func setPriority(_ priority: UILayoutPriority) {
        constraints.forEach({$0.priority = priority })
    }
    
    public func constraintsForItem(item: AnyObject, orderFilter: ItemOrderFilterOptions = .all) -> [NSLayoutConstraint] {
        return constraints.filter { ( orderFilter.contains(.first) && $0.firstItem === item ) || ( orderFilter.contains(.second) && $0.secondItem === item ) }
    }
    
    public func constraintsForAttribute(attribute: NSLayoutAttribute, orderFilter: ItemOrderFilterOptions = .all) -> [NSLayoutConstraint] {
        return constraints.filter { ( orderFilter.contains(.first) && $0.firstAttribute == attribute ) || ( orderFilter.contains(.second) && $0.secondAttribute == attribute ) }
    }
}

extension ConstraintSet: CustomStringConvertible {
	public var description: String { return "[ConstraintSet count: \(constraints.count)]" }
}
