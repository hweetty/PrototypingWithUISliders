//
//  SliderFactory.swift
//  PrototypeWithSliders
//
//  Created by Jerry Yu on 2017-04-09.
//  Copyright © 2017 Jerry Yu. All rights reserved.
//

import UIKit

public struct SliderObject {
	let slider: UISlider
	let valueLabel: UILabel
	let cb: (_ newValue: CGFloat)->Void
}

public class SliderFactory {

	public static var main = SliderFactory()

	private let stackView = UIStackView()
	var sliders = [SliderObject]()

	public func show(in view: UIView) {
		view.addSubview(stackView)
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.spacing = 10
		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
			stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
			stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
		])

		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(white: 0.95, alpha: 0.87)
		view.insertSubview(backgroundView, belowSubview: stackView)
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
			backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
			backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
		])
	}

	@discardableResult
	func addSlider(named: String = "", for constraint: NSLayoutConstraint, minValue: CGFloat, maxValue: CGFloat, cb: (()->Void)? = nil) -> UISlider {

		let slider = new(named: named, value: Float(constraint.constant), minValue: Float(minValue), maxValue: Float(maxValue)) { newValue in
			constraint.constant = CGFloat(newValue)
			cb?()
		}

		return slider
	}

	private func new(named: String, value: Float, minValue: Float, maxValue: Float, cb: @escaping (_ newValue: CGFloat)->Void) -> UISlider {

		let valueLabel = UILabel()
		valueLabel.text = String(format: "%0.1f", value)

		let slider = UISlider()
		slider.minimumValue = minValue
		slider.maximumValue = maxValue
		slider.value = value
		slider.addTarget(self, action: #selector(valueChanged(slider:)), for: .valueChanged)

		let obj = SliderObject(slider: slider, valueLabel: valueLabel, cb: cb)
		sliders.append(obj)

		let nameLabel = UILabel()
		nameLabel.text = named

		let innerStack = UIStackView()
		innerStack.spacing = 4
		innerStack.distribution = .fill
		innerStack.addArrangedSubview(nameLabel)
		innerStack.addArrangedSubview(slider)
		innerStack.addArrangedSubview(valueLabel)
		stackView.addArrangedSubview(innerStack)

		return slider
	}

	@objc private func valueChanged(slider: UISlider) {
		let value = CGFloat(slider.value)
		for obj in sliders {
			if slider == obj.slider {
				obj.valueLabel.text = String(format: "%0.1f", value)
				obj.cb(value)
				return
			}
		}
	}
}
