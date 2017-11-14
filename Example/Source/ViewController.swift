//
//  ViewController.swift
//  ConstraintSet Example
//
//  Created by Michael Bedar on 11/13/17.
//  Copyright © 2017 Michael Bedar. All rights reserved.
//

import UIKit
import ConstraintSet


class ViewController: UIViewController {
	
	let outerView: UIView
	let innerView: UIView
	let topBarView: UIView
	let label: UILabel
	
	var outerConstraints: ViewEdgeConstraintSet?
	var innerConstraints: ViewEdgeConstraintSet?
	
	var outerPadding: CGFloat = 30
	var innerInsets: UIEdgeInsets = .init(top: 20, left: 4, bottom: 20, right: 4)
	var topBarPadding: CGFloat = 8
	var topBarHeight: CGFloat = 100

	init() {
		outerView = UIView()
		innerView = UIView()
		topBarView = UIView()
		label = UILabel()
		
		super.init(nibName: nil, bundle: nil)
		
		view.backgroundColor = UIColor.darkGray
		outerView.backgroundColor = UIColor.lightGray
		innerView.backgroundColor = UIColor.white
		topBarView.backgroundColor = UIColor.red.withAlphaComponent(0.20)
		
		label.textAlignment = .center
		label.text = "📌 Constrain Your Self "
		
		view.addSubview(outerView)
		outerView.addSubview(innerView)
		innerView.addSubview(topBarView)
		topBarView.addSubview(label)
		
		outerConstraints = outerView.pinEdges(to: view.safeAreaLayoutGuide, insets: UIEdgeInsets(constant: outerPadding))
		innerView.pinEdges(to: outerView, insets: innerInsets)
		
		let topBarConstraints = topBarView.pinEdges(to: innerView, edges: ViewEdgeConstraintSet.EdgeType.allExceptBottom, insets: UIEdgeInsets(constant: topBarPadding), activate: false)
		topBarConstraints.addConstraint(topBarView.heightAnchor.constraint(equalToConstant: topBarHeight))
		topBarConstraints.activateAllConstraints()
		
		label.pinEdgesToSuperView(insets: UIEdgeInsets(constant: topBarPadding))
		
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

