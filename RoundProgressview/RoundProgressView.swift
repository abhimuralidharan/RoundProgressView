//
//  RoundProgressView.swift
//  RoundProgressview
//
//  Created by Apple on 03/04/18.
//  Copyright © 2018 Abhilash. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

protocol RoundProgressViewDelegate {
    func roundProgressViewProgressAnimationDidFinish(sender:RoundProgressView?)
}
class RoundProgressView: UIView {
    
    var delegate: RoundProgressViewDelegate? // delegate
    var percent: CGFloat = 0.0 { // 0 to 100
        didSet {
            setNeedsDisplay()
        }
    }
    var strokeColor = UIColor.red
    var lineWidth: CGFloat = 4.0
    var fractionColorsEnabled = false
    var fractionColors: [UIColor]?

    private var maxValue: CGFloat = 100.0
    private var minValue: CGFloat = 0.0

    private var startAngle: CGFloat = 0.0
    private var endAngle: CGFloat = 0.0
    private var bezierPath: UIBezierPath!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        // Initialization code
        backgroundColor = UIColor.clear
        // Determine our start and stop angles for the arc (in radians)
        startAngle = CGFloat((CGFloat.pi / 2))
        endAngle = CGFloat((CGFloat.pi * 2))
    }
    
    override func draw(_ rect: CGRect) {
        guard percent > minValue, percent < maxValue else {
            print("Error: progress percent is invalid")
            delegate?.roundProgressViewProgressAnimationDidFinish(sender: self)
            return
        }
        
        // Display our percentage as a string
        bezierPath = UIBezierPath()
        // Create our arc, with the correct angles
        bezierPath.addArc(withCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2), radius: rect.size.height / 2 - 5, startAngle: startAngle, endAngle: endAngle * (percent / 100.0) + startAngle, clockwise: true)

        bezierPath.lineWidth = lineWidth
        if fractionColorsEnabled {
          fractionColor().setStroke()
        } else {
        strokeColor.setStroke()
        }
       
        self.bezierPath.stroke()
        
}
    private func fractionColor() -> UIColor {
        guard let fractionColorsArr = fractionColors, !fractionColorsArr.isEmpty else {
            return strokeColor
        }
        let colorCount = fractionColorsArr.count
        let fractionPercent = (percent/maxValue) * 100
        let singleFractionVal = maxValue/colorCount.floatValue

        let currentColorIndexFloatVal = fractionPercent/singleFractionVal
        let arrayIndex = Int(currentColorIndexFloatVal.rounded(.awayFromZero))
        return fractionColorsArr[arrayIndex - 1]

    }
    
}
