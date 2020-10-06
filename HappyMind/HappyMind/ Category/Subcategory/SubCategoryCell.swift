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

    private lazy var imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(resource: .icon)
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
        setupImageIconConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        containerImageView.addShadow(cornerRadius: 4)
        imageView.roundCorners(corners: .allCorners, radius: 4)
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

    private func setContainerImageView() {
        containerView.addSubview(containerImageView)
        NSLayoutConstraint.activate([
            containerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            containerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            containerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
            containerImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)
            ])
    }

    private func setupConstraints() {
        containerImageView.addSubview(imageView)
        imageView.addSubview(categoryNameLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerImageView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor),
            categoryNameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            categoryNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            categoryNameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8)
            ])
    }
    
    private func setupImageIconConstraints() {
        imageView.addSubview(imageIcon)
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            imageIcon.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            imageIcon.heightAnchor.constraint(equalToConstant: 20),
            imageIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    override func setData(_ data: SubCategoryModel) {
        layoutIfNeeded()
        imageView.image = data.image
        categoryNameLabel.text = data.name
    }
}

