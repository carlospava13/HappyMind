//
//  SubCategoryCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class SubCategoryCell: BaseCollectionCell<SubCategoryModel> {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContainerViewConstraints()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        imageView.roundCorners(corners: .allCorners, radius: 10)
        imageView.addElevation()
        containerView.addShadow()
    }

    func setupView() {
        contentView.addSubview(containerView)
    }

    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }

    func setupConstraints() {
        containerView.addSubview(imageView)
        containerView.addSubview(categoryNameLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            categoryNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            categoryNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            categoryNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
        layoutIfNeeded()
    }

    override func setData(_ data: SubCategoryModel) {
        imageView.image = data.image
        categoryNameLabel.text = data.name
        layoutSubviews()
    }
}

