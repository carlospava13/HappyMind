//
//  CategoryViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class CategoryViewController: BaseViewController {

    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView(frame: .zero, layout: .list)
        collectionView.setHeight(250)
        return collectionView
    }()

    private var dataSource: CategoryDataSource = {
        CategoryDataSource(identifierCell: .categoryCell)
    }()

    private var ownPresenter: CategoryPresenterType? = {
        CategoryPresenter()
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        presenter = ownPresenter
        ownPresenter?.bind(self)
        setupCollectionView()
        setupConstraints()
        super.viewDidLoad()
    }

    func setupConstraints() {
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guides.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            ])
    }

    func setupCollectionView() {
        let identifierCell = CollectionViewCellIdentifier.categoryCell
        collectionView.register(CategoryCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.categoryDelegate = self
    }
}

extension CategoryViewController: CategoryView {
    func setData(_ categories: [Section<CategoryModel>]) {
        dataSource.setData(categories)
    }
}

extension CategoryViewController: CategoryDelegate {
    func didSelect(_ item: SubCategoryModel) {
        print("Item = \(item)")
    }
}
