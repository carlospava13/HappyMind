//
//  GenericCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class GenericCell<T>: BaseCollectionCell<T> {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()

    lazy var nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.calibriFont()
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContainerViewConstraints()
        setImageViewConstraints()
        setNameCategoryLabelConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        contentView.addSubview(containerView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.addShadow(cornerRadius: 20)
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
}
