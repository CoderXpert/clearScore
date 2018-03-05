//
//  CAShapeLayerExtension.swift
//  ClearScore
//
//  Created by luca silvestro on 03/03/18.
//  Copyright © 2018 Clear Score. All rights reserved.
//

import UIKit


// MARK: - Shapes
extension CAShapeLayer {
    
    static func circle(center: CGPoint, arcRadius: CGFloat, lineWidth: CGFloat, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) -> CAShapeLayer {
        
        let pathCircle = CAShapeLayer.makeCirclePath(center: center, arcRadius: arcRadius)
        
        return makeShape(lineWidth: lineWidth, path: pathCircle.cgPath, strokeStart: strokeStart, strokeEnd: strokeEnd, strokeColor: strokeColor, fillColor: fillColor, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: shadowOffsset)
    }
    
    private static func makeShape(lineWidth: CGFloat, path: CGPath, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) -> CAShapeLayer {
        
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.lineCap = kCALineCapRound
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.cgColor
        arc.fillColor = fillColor.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset
        
        return arc
    }
    
    static private func makeCirclePath(center: CGPoint, arcRadius: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: center, radius: arcRadius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat((Double.pi * 2.0) - Double.pi/2), clockwise: true)
    }
}

// MARK: - Animations
extension CAShapeLayer {
    func animateStrokeEnd(to value: CGFloat, duration: Double, completion: (() -> Void)? = nil) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = value
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        add(animation, forKey: animation.keyPath)
        completion?()
    }
}
