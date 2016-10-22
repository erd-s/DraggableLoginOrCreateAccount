//
//  DragReceiverView.swift
//  DragButtons
//
//  Created by Christopher Erdos on 10/21/16.
//  Copyright © 2016 Erdos. All rights reserved.
//

import UIKit

class DragReceiverView: UIView {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		isUserInteractionEnabled = true
		alpha = 0.5
	}
	
	//--------------------------------------
	// MARK: - Layout
	//--------------------------------------
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.cornerRadius = self.bounds.height/2
		clipsToBounds = true
	}
	
	func addText(text: String, font: UIFont?) {
		let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
		newLabel.text = text
		newLabel.textAlignment = .center
		newLabel.font = font
		newLabel.textColor = .black
		
		addSubview(newLabel)
	}
}

extension DragReceiverView {
	/**
	Checks to see if a view overlaps with another view.
	
	- parameter view: a view to test intersection with.
	- returns: `true` if they interesect, `false` if they dont.
	*/
	func overlapsWithCenterOf(otherView: UIView) -> Bool {
		//makes small rectangle around the center
		let scale: CGFloat = 0.25
		
		//Receiving Rect -------------------------
		let newWidth = frame.width * scale
		let newHeight = frame.height * scale
		let newX =	frame.origin.x + ((1-scale)/2)*frame.width
		let newY = frame.origin.y + ((1-scale)/2)*frame.height
		let rect = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
		
		//otherView Rect ----------------------
		//TODO: rename variables
		let widthOther = otherView.frame.width * scale
		let heightOther = otherView.frame.height * scale
		let xOther =	otherView.frame.origin.x + ((1-scale)/2)*otherView.frame.width
		let yOther = otherView.frame.origin.y + ((1-scale)/2)*otherView.frame.height
		let rectOther = CGRect(x: xOther, y: yOther, width: widthOther, height: heightOther)
		
		if rect.intersects(rectOther) {
			return true
		} else {
			return false
		}
	}
}
