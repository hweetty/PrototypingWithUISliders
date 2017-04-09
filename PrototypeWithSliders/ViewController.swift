//
//  ViewController.swift
//  PrototypeWithSliders
//
//  Created by Jerry Yu on 2017-04-09.
//  Copyright © 2017 Jerry Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let topView = UIView()
	let bottomView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()

		topView.backgroundColor = UIColor(red: 57/255.0, green: 142/255.0, blue: 105/255.0, alpha: 1)
		view.addSubview(topView)
		topView.translatesAutoresizingMaskIntoConstraints = false

		bottomView.backgroundColor = UIColor(red: 198/255.0, green: 93/255.0, blue: 146/255.0, alpha: 1)
		view.addSubview(bottomView)
		bottomView.translatesAutoresizingMaskIntoConstraints = false

		// This allows sliders to be added to self.view
		SliderFactory.main.show(in: view)

		setupConstraints()
	}

	private func setupConstraints() {
		// Changes that affect topView also affect bottomView
		NSLayoutConstraint.activate([
			bottomView.leftAnchor.constraint(equalTo: topView.leftAnchor),
			bottomView.rightAnchor.constraint(equalTo: topView.rightAnchor),
			bottomView.heightAnchor.constraint(equalTo: topView.heightAnchor),
		])

		let adjustableConstraints = [
			("top", topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)),
			("left", topView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12)),
			("right", topView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12)),
			("height", topView.heightAnchor.constraint(equalToConstant: 53.0)),

			("between", bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20)),
		]

		for (name, constraint) in adjustableConstraints {
			NSLayoutConstraint.activate([constraint])
			let min = constraint.constant - 50
			let max = constraint.constant + 50
			SliderFactory.main.addSlider(named: name, for: constraint, minValue: min, maxValue: max)
		}
	}
}

