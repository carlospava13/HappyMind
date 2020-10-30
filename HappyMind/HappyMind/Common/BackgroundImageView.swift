//
//  BackgroundImageView.swift
//  HappyMind
//
//  Created by Carlos Pava on 29/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SDWebImage

final class BackgroundImageView: UIView {

    private lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill 
        imageView.image = UIImage(named: "image1")
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setGadient()
    }

    private func setImageViewConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    private func setGradientViewConstraints() {
        addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setGadient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.white.withAlphaComponent(0.5 ).cgColor,
                                UIColor.white.cgColor,
                                UIColor.white.cgColor]
        imageView.layer.addSublayer(gradientLayer)
    }

    func set(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url) { (_, _, _, _) in }
        }
    }
}
