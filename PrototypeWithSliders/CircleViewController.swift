//
//  CircleViewController.swift
//  PrototypeWithSliders
//
//  Created by Jerry Yu on 2017-04-09.
//  Copyright © 2017 Jerry Yu. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let circleView = CircleView(frame: view.bounds.offsetBy(dx: 0, dy: -50))
		view.addSubview(circleView)

		SliderFactory.main.show(in: view)

		SliderFactory.main.addSlider(named: "Inner", for: &circleView.innerRadius, minValue: 30, maxValue: 80, cb: circleView.setNeedsDisplay)
		SliderFactory.main.addSlider(named: "Offset", for: &circleView.offset, minValue: -CGFloat.pi, maxValue: CGFloat.pi, cb: circleView.setNeedsDisplay)
		SliderFactory.main.addSlider(named: "Hue", for: &circleView.initialHue, minValue: 0, maxValue: 1, cb: circleView.setNeedsDisplay)
		SliderFactory.main.addSlider(named: "Hue delta", for: &circleView.hueDelta, minValue: 0, maxValue: 1/12.0, cb: circleView.setNeedsDisplay)
    }

}
