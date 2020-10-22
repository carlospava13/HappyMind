//
//  GenericCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView

class GenericCell<T>: BaseCollectionCell<T> {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()

    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.isSkeletonable = true
        imageView.backgroundColor = .gray
        return imageView
    }()

    lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.calibriFont()
        label.textColor = .white
        label.isSkeletonable = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        setupView()
        setupContainerViewConstraints()
        setImageViewConstraints()
        setIndicatorConstraints()
        setNameCategoryLabelConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    private func setIndicatorConstraints() {
        containerView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
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
}
