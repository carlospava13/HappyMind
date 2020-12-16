//
//  WelcomeHeader.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class WelcomeHeader: UICollectionReusableView {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange()
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.calibriRegularFont()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        setupTitleLabelConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        let y: CGFloat = containerView.frame.height
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: 0, y: y))
        myBezier.addQuadCurve(to: CGPoint(x: rect.width, y: y), controlPoint: CGPoint(x: rect.width / 2, y: rect.height + 20))
        myBezier.addLine(to: CGPoint(x: rect.width, y: containerView.frame.height))
        myBezier.addLine(to: CGPoint(x: 0, y: containerView.frame.height))
        myBezier.close()
        let context = UIGraphicsGetCurrentContext()
        //// Shadow Declarations
        let shadow = UIColor.gray
        let shadowOffset = CGSize(width: 3, height: 3)
        let shadowBlurRadius: CGFloat = 20
        context!.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: (shadow as UIColor).cgColor)

        context!.setLineWidth(4.0)
        UIColor.orange().setFill()
        myBezier.fill()
    }
    private func setupView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64)
            ])
    }

    private func setupTitleLabelConstraints() {
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32)
            ])
    }

    func set(title: String) {
        titleLabel.text = title
    }
}
