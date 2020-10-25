//
//  DiskView.swift
//  HappyMind
//
//  Created by Carlos Pava on 23/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class DiskView: UIView {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var diskImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "image1")
        return imageView
    }()

    private lazy var miniCircleView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
            y: 0,
            width: 20, height: 20))
        view.alpha = 0
        view.backgroundColor = .white
        return view
    }()

    private var progressLayer = CAShapeLayer()
    private var miniCircleLayer = CAShapeLayer()
    private var duration: Float = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        setContainerViewConstraints()
        setDiskImageViewConstraints()
        addSubview(self.miniCircleView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        miniCircleView.roundCorners(corners: .allCorners, radius: miniCircleView.frame.width / 2)
        diskImageView.roundCorners(corners: .allCorners, radius: diskImageView.frame.width / 2)
        createCircularPath()
        createMiniDiskPath()
        createPointWhitePath()
    }

    private func setContainerViewConstraints() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setDiskImageViewConstraints() {
        containerView.addSubview(diskImageView)
        NSLayoutConstraint.activate([
            diskImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            diskImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            diskImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            diskImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
    }

    private func createCircularPath() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: diskImageView.frame.size.width / 2.0, y: diskImageView.frame.size.height / 2.0),
            radius: diskImageView.frame.size.height / 2.0,
            startAngle: .pi / 2,
            endAngle: -3 * .pi / 2,
            clockwise: false)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .square
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.orange().cgColor
        diskImageView.layer.addSublayer(progressLayer)
    }

    private func createMiniDiskPath() {
        let miniCirclePath = UIBezierPath(
            arcCenter: CGPoint(x: diskImageView.frame.size.width / 2.0, y: diskImageView.frame.size.height / 2.0),
            radius: 35,
            startAngle: .pi / 2,
            endAngle: -3 * .pi / 2,
            clockwise: false)
        let miniCircleLayer = CAShapeLayer()
        miniCircleLayer.path = miniCirclePath.cgPath
        miniCircleLayer.fillColor = UIColor.white.withAlphaComponent(0.5).cgColor
        diskImageView.layer.addSublayer(miniCircleLayer)
    }

    private func createPointWhitePath() {
        let pointWhitePath = UIBezierPath(
            arcCenter: CGPoint(x: diskImageView.frame.size.width / 2.0, y: diskImageView.frame.size.height / 2.0),
            radius: 7,
            startAngle: .pi / 2,
            endAngle: -3 * .pi / 2,
            clockwise: false)
        let pointWhiteLayer = CAShapeLayer()
        pointWhiteLayer.path = pointWhitePath.cgPath
        pointWhiteLayer.fillColor = UIColor.white.cgColor
        diskImageView.layer.addSublayer(pointWhiteLayer)
    }

    private func calculateAngle(current: Double) {
        DispatchQueue.global(qos: .background).async {
            let progress: Double = 1 - current
            var endAngle: CGFloat = CGFloat(progress)
            if progress <= 0 {
                endAngle = CGFloat(0 * (2 * Double.pi) - (3 * Double.pi / 2))
            } else {
                endAngle = CGFloat(progress * (2 * Double.pi) - (3 * Double.pi / 2))
            }
            var endX = (cos(endAngle) / 2 + 0.5)
            var endY = (sin(endAngle) / 2 + 0.5)

            DispatchQueue.main.async {
                endX *= self.diskImageView.frame.size.height / 2.0 * 2
                endY *= self.diskImageView.frame.size.height / 2.0 * 2
                endX -= self.diskImageView.frame.origin.x
                endY -= self.diskImageView.frame.origin.y
                endY -= 10
                endX -= 10
                if !endX.isNaN && !endY.isNaN {
                    self.miniCircleView.alpha = 1
                    self.miniCircleView.frame.origin = CGPoint(x: endX, y: endY)
                }
                self.progressLayer.strokeEnd = CGFloat(current)
            }
        }
    }

    func setDuration(_ duration: Float) {
        self.duration = duration
    }

    func currentTimer(time: Float) {
        let current = time / duration
        calculateAngle(current: Double(current))
    }

    func setImage(_ image: UIImage) {
        diskImageView.image = image
    }
}
