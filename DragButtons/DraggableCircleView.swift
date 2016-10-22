//
//  DraggableCircleView.swift
//  DragButtons
//
//  Created by Christopher Erdos on 10/21/16.
//  Copyright © 2016 Erdos. All rights reserved.
//

import UIKit

/**
Implement this delegate protocol so that the receiving circles know when overlap is made.
*/
protocol DraggableCircleViewDelegate {
	func viewPositionUpdated(draggableCircle: DraggableCircleView)
}

class DraggableCircleView: UIView {
	var originalCenter: CGPoint!
	lazy var big: Bool! = { return false }()
	var draggableCircleDelegate: DraggableCircleViewDelegate?
	var textLabel: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		isUserInteractionEnabled = true
		alpha = 0.5
		addDragGestures()
	}
	
	//--------------------------------------
	// MARK: - Layout
	//--------------------------------------
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.cornerRadius = self.bounds.height/2
		clipsToBounds = true
		originalCenter = center
		
		if textLabel == nil {
			addText(text: "D R A G", font: UIFont.systemFont(ofSize: 15))
		}
	}
	
	func addText(text: String, font: UIFont?) {
		textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
		textLabel.text = text
		textLabel.textAlignment = .center
		textLabel.font = font
		textLabel.textColor = .black
		
		addSubview(textLabel)
	}
	
	
	/**
	Pins to another view, hides the label, disables further user interation.
	
	- parameter view: The view to pin to.
	*/
	func pinTo(otherView: UIView) {
		UIView.animate(withDuration: 0.15) {
			self.center = otherView.center
			self.textLabel.alpha = 0
		}
		
		gestureRecognizers?.removeAll()
		isUserInteractionEnabled = false
		
		transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
	}
}

//--------------------------------------
// MARK: - Gesture Recognizing
//--------------------------------------
extension DraggableCircleView: UIGestureRecognizerDelegate {
	func addDragGestures() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
		pan.delegate = self
		addGestureRecognizer(pan)
	}
	
	func panHandler(panGesture: UIPanGestureRecognizer) {
		//drags the circle with it
		let translation = panGesture.translation(in: self.superview)
		center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
		panGesture.setTranslation(CGPoint.zero, in: self)
		
		//lets receiver view know the position of the draggable circle.
		if let del = draggableCircleDelegate {
			del.viewPositionUpdated(draggableCircle: self)
		}
		
		//snaps back when touch ends
		if panGesture.state == .ended {
			if !bounds.contains(originalCenter) {
				UIView.animate(withDuration: 0.2, animations: {
					self.center = self.originalCenter
					if self.big! {
						//gets back to normal size when you deselect
						self.transform = CGAffineTransform(scaleX: 1/1.05, y: 1/1.05)
						self.big = false
					}
				})
			}
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		//shows little pop when you start dragging
		if !self.big! {
			transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
			big = true
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if big! {
			//gets back to normal size when you deselect
			transform = CGAffineTransform(scaleX: 1/1.05, y: 1/1.05)
			big = false
		}
	}

}
