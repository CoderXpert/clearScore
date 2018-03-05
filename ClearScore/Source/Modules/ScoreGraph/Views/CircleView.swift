//
//  CircleView.swift
//  ClearScore
//
//  Created by luca silvestro on 03/03/18.
//  Copyright © 2018 Clear Score. All rights reserved.
//

import UIKit

@IBDesignable class CircleView: UIView {

    // MARK - Properties
    
    /// Color of the graph's outer frame
    @IBInspectable var outerCircleColor: UIColor = Constants.Colors.outerCircle
    
    /// Thickness of the the graph's outer frame
    @IBInspectable var outerCirclePathWidth: CGFloat = 1
    
    /// Shadow radius amount of the graph's outer frame
    @IBInspectable var outerCircleShadowRadius: CGFloat = 5.0
    
    /// Shadow opacity of the graph's outer frame
    @IBInspectable var outerCircleShadowOpacity: Float = 0.5
    
    /// Radius of the graph's outer frame
    @IBInspectable var outerCircleArcRadius: CGFloat = 100
    
    /// Color of the graph's circular progress view
    @IBInspectable var innerCircleColor: UIColor = Constants.Colors.innerCircle
    
    /// Thickness of the the graph's circular progress view
    @IBInspectable var innerCirclePathWidth: CGFloat = 5
    
    /// Shadow radius amount of the graph's circular progress view
    @IBInspectable var innerCircleShadowRadius: CGFloat = 5.0
    
    /// Shadow opacity of the graph's circular progress view
    @IBInspectable var innerCircleShadowOpacity: Float = 0.2
    
    /// Padding between the progress view and the outer frame
    @IBInspectable var circlesPadding: CGFloat = 5.0
    
    /// Label appearing inside the graph at the very top
    @IBOutlet var titleLabel: UILabel!
    
    /// Label appearing inside the graph holding the current score
    @IBOutlet var creditScoreLabel: UILabel!
    
    /// Label appearing inside the graph holding the maximum amount possible for the credit score
    @IBOutlet var maximumScoreLabel: UILabel!
    
    /// Radius of the graph's circular progress view
    private var innerCircleArcRadius: CGFloat {
        return outerCircleArcRadius - outerCirclePathWidth/2 - innerCirclePathWidth/2 - circlesPadding
    }
    
    /// Center for both the graph's outer frame and the progress view
    private var circlesCenter: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY) }
    
    /// Progress view layer
    private var innerCircle: CAShapeLayer?
    
    // MARK: - Setup
    
    /// Called to update the view with the latest credit report informations
    ///
    /// - Parameter reportInfo: entity representing the latest credit report information
    func update(with reportInfo: CreditReportInfo) {
        creditScoreLabel.text =  "\(reportInfo.score)"
        maximumScoreLabel.text = "out of \(reportInfo.maxScore)"
        
        innerCircle?.animateStrokeEnd(to: CGFloat(reportInfo.percentage), duration: Constants.Animation.duration)
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        drawOuterCircle()
        drawInnerCircle()
    }
    
    // MARK - Private
    
    /// Adds the graph's outer frame sublayer
    private func drawOuterCircle() {
        let outerCircle = CAShapeLayer.circle(center: circlesCenter,
                                              arcRadius: outerCircleArcRadius,
                                              lineWidth: outerCirclePathWidth,
                                              strokeStart: 0.0,
                                              strokeEnd: 1,
                                              strokeColor: outerCircleColor,
                                              fillColor: Constants.Colors.fill,
                                              shadowRadius: outerCircleShadowRadius,
                                              shadowOpacity: outerCircleShadowOpacity,
                                              shadowOffsset: .zero)
        
        layer.addSublayer(outerCircle)
    }
    
    /// Adds the graph's progress view layer
    private func drawInnerCircle() {
        let innerCircle = CAShapeLayer.circle(center: circlesCenter,
                                           arcRadius: innerCircleArcRadius,
                                           lineWidth: innerCirclePathWidth,
                                         strokeStart: 0.0,
                                           strokeEnd: 0.0,
                                         strokeColor: innerCircleColor,
                                           fillColor: UIColor.clear,
                                        shadowRadius: innerCircleShadowRadius,
                                       shadowOpacity: innerCircleShadowOpacity,
                                       shadowOffsset: .zero)
        
        self.innerCircle = innerCircle
        layer.addSublayer(innerCircle)
    }
}

// MARK: - Constants
extension CircleView {
    struct Constants {
        struct Colors {
            static let outerCircle = UIColor.black
            static let fill = UIColor.clear
            static let innerCircle = UIColor.yellow
        }
        
        struct Animation {
            static let duration: Double = 1
        }
    }
}
