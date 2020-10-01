//
//  CategoryCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class CategoryCell: BaseCollectionCell<CategoryModel> {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var collectionView: CollectionView = {
        CollectionView(frame: .zero, layout: .gridCuston(190))
    }()

    private lazy var dataSource: SubCategoryDataSource = {
        SubCategoryDataSource(identifierCell: .defaultCell)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContainerViewConstraints()
        setCategoryNameLabelConstraints()
        setCollectionViewConstraints()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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

    func setCategoryNameLabelConstraints() {
        containerView.addSubview(categoryNameLabel)
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            categoryNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            categoryNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            categoryNameLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
    }

    func setCollectionViewConstraints() {
        containerView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            ])
    }

    func setupCollectionView() {
        let identifierCell = CollectionViewCellIdentifier.defaultCell
        collectionView.register(SubCategoryCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    override func setData(_ data: CategoryModel) {
        categoryNameLabel.text = data.title
        dataSource.setData([data.subcategories])
    }
}
