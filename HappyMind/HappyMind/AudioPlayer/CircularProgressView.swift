//
//  CircularProgressView.swift
//  HappyMind
//
//  Created by Carlos Pava on 22/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//


import UIKit
final class CircularProgressView: UIView {

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var miniCircleLayer = CAShapeLayer()
    
    private var duration : Float = 0.0

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        createCircularPath()
    }

    func createCircularPath() {

        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: 80,
            startAngle: .pi / 2  ,
            endAngle: -3 * .pi / 2,
            clockwise: false)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 20.0
        circleLayer.strokeColor = UIColor.black.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
//        progressLayer.strokeStart = 0.5
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.orange().cgColor
        let miniCircle = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 30, height: 30))
        miniCircleLayer.path = miniCircle.cgPath
        miniCircleLayer.fillColor = UIColor.red.cgColor
        miniCircleLayer.strokeEnd = 0
        progressLayer.addSublayer(miniCircleLayer)
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)



    }
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        miniCircleLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    func setDuration(_ duration: Float) {
        self.duration = duration
    }
    
    func currentTimer(time: Float) {
        let current = time / duration
        progressLayer.strokeEnd = CGFloat(current)
    }

    func pauseLayer() {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
}
