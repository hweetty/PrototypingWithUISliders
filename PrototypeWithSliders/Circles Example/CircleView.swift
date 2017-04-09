//
//  CircleView.swift
//  PrototypeWithSliders
//
//  Created by Jerry Yu on 2017-04-09.
//  Copyright © 2017 Jerry Yu. All rights reserved.
//

import UIKit

class CircleView: UIView {

	var iterations = 12
	var innerRadius: CGFloat = 50
	var outerRadius: CGFloat = 100
	var offset: CGFloat = 0
	var initialHue: CGFloat = 0
	var hueDelta: CGFloat = 0

    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!

		ctx.setLineWidth(3)
		ctx.setFillColor(UIColor.white.cgColor)
		ctx.fill(bounds)

		let centerPoint = ccp(bounds.midX, bounds.midY)

		for i in 0..<iterations {
			// Set line color
			let hue = initialHue + CGFloat(i)*hueDelta
			let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
			ctx.setStrokeColor(color.cgColor)

			// Calculate line endpoints
			let angle = 2*CGFloat.pi * CGFloat(i)/CGFloat(iterations)
			let p1 = pointOnCircle(centered: centerPoint, radius: innerRadius, offsetRadian: angle + offset)
			let p2 = pointOnCircle(centered: centerPoint, radius: outerRadius, offsetRadian: angle)

			// Stroke line
			ctx.move(to: p1)
			ctx.addLine(to: p2)
			ctx.strokePath()
		}
    }

}

// MARK: Helper

public func pointOnCircle(centered centerPoint: CGPoint, radius: CGFloat, offsetRadian: CGFloat) -> CGPoint {
	let dx = radius * cos(offsetRadian)
	let dy = radius * sin(offsetRadian)
	let p = centerPoint + ccp(dx, dy)
	return p
}

public func ccp(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
	return CGPoint(x: x, y: y)
}

public extension CGPoint {
	static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return ccp(lhs.x + rhs.x, lhs.y + rhs.y)
	}
	static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return ccp(lhs.x - rhs.x, lhs.y - rhs.y)
	}
}
