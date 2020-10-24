//
//  LoginImageBackgroundView.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class LoginImageBackgroundView: UIView {

    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .topLeft
        imageView.image = UIImage(named: "toplogin")
        return imageView
    }()

    private lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "bottomlogin")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTopImageViewConstraints()
        setBottomImageViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setTopImageViewConstraints() {
        addSubview(topImageView)
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.heightAnchor.constraint(equalToConstant: 190)
            ])
    }

    private func setBottomImageViewConstraints() {
        addSubview(bottomImageView)
        NSLayoutConstraint.activate([
            bottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomImageView.heightAnchor.constraint(equalToConstant: 190)
            ])
    }
}
