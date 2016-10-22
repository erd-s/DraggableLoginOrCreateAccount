//
//  DragViewController.swift
//  DragButtons
//
//  Created by Christopher Erdos on 10/21/16.
//  Copyright © 2016 Erdos. All rights reserved.
//

import UIKit

class DragViewController: UIViewController {
	//--------------------------------------
	// MARK: - Outlets
	//--------------------------------------
	@IBOutlet weak var draggingCircleView: DraggableCircleView!
	@IBOutlet weak var leftReceiverView: DragReceiverView!
	@IBOutlet weak var rightReceiverView: DragReceiverView!
	
	//--------------------------------------
	// MARK: - View
	//--------------------------------------
	override func viewDidLoad() {
		super.viewDidLoad()
		
		draggingCircleView.draggableCircleDelegate = self
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		leftReceiverView.addText(text: "SIGN UP", font: nil)
		rightReceiverView.addText(text: "LOGIN", font: nil)
	}
}


extension DragViewController: DraggableCircleViewDelegate {
	func viewPositionUpdated(draggableCircle: DraggableCircleView) {
		if leftReceiverView.overlapsWithCenterOf(otherView: draggableCircle) {
			print("left overlap")
			
			draggableCircle.pinTo(otherView: leftReceiverView)
			//do stuff here
		}
		
		if rightReceiverView.overlapsWithCenterOf(otherView: draggableCircle) {
			print("right overlap")
			
			draggableCircle.pinTo(otherView: rightReceiverView)
			//do stuff here
		}
	}
}
