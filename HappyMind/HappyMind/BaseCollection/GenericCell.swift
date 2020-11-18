//
//  GenericCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView
import SDWebImage
class GenericCell<T>: BaseCollectionCell<T> {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        return imageView
    }()

    lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.calibriBoldFont(size: 25)
        label.textColor = .white
        return label
    }()

    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        setupView()
        setupContainerViewConstraints()
        setImageViewConstraints()
        setNameCategoryLabelConstraints()
        checkImageViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.roundCorners(corners: .allCorners, radius: 5)
        setGadient()
    }

    private func setupView() {
        contentView.addSubview(containerView)
    }

    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }

    private func setImageViewConstraints() {
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            ])
    }

    private func setNameCategoryLabelConstraints() {
        containerView.addSubview(nameCategoryLabel)
        NSLayoutConstraint.activate([
            nameCategoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            nameCategoryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            nameCategoryLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8)
            ])
    }

    private func checkImageViewConstraints() {
        containerView.addSubview(checkImageView)
        NSLayoutConstraint.activate([
            checkImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            checkImageView.leadingAnchor
                .constraint(equalTo: imageView.trailingAnchor, constant: -36),
            checkImageView.heightAnchor.constraint(equalToConstant: 20),
            checkImageView.widthAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    private func setGadient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.orange().withAlphaComponent(0.2 ).cgColor,
                                UIColor.orange().withAlphaComponent(0.2 ).cgColor]
        imageView.layer.addSublayer(gradientLayer)
    }
    
    func set(checked: Bool) {
        checkImageView.image = checked ? UIImage(named: "ischecked") :  UIImage(named: "isnotchecked")
    }
}
