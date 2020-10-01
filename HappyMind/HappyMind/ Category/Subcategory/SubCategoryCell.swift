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

    private lazy var containerImageView: UIView = {
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
        setContainerImageView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        imageView.roundCorners(corners: .allCorners, radius: 10)
        containerImageView.roundCorners(corners: .allCorners, radius: 10)
        containerImageView.addElevation(color: .red)
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

    private func setContainerImageView() {
        containerView.addSubview(containerImageView)
        NSLayoutConstraint.activate([
            containerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            containerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            containerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            containerImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            ])
    }

    func setupConstraints() {
        containerImageView.addSubview(imageView)
        imageView.addSubview(categoryNameLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerImageView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: -8),
            categoryNameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            categoryNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            categoryNameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16)
            ])
        layoutIfNeeded()
    }

    override func setData(_ data: SubCategoryModel) {
        imageView.image = data.image
        categoryNameLabel.text = data.name
        layoutSubviews()
    }
}

