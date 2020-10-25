//
//  CategoryViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView
import HappyMindCore

final class CategoryViewController: BaseListViewController {

    private var dataSource: CategoryDataSource = {
        CategoryDataSource(identifierCell: .categoryCell)
    }()

    private var ownPresenter: CategoryPresenterType! {
        presenter as? CategoryPresenterType
    }

    override func viewDidLoad() {
        setNavigationTransparent(title: .localized(.happyMindTitle),
                                 backgroundColor: .white)
        setFontNavigationBar(font: UIFont.JosefinSansRegularFont(size: 30)!,
                             color: .orange())
        ownPresenter?.bind(self)
        setupCollectionView()
        super.viewDidLoad()
    }

    override func setupCollectionView() {
        super.setupCollectionView()
        let identifierCell = CollectionViewCellIdentifier.categoryCell
        collectionView.register(CategoryCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.categoryDelegate = self
    }
}

extension CategoryViewController: CategoryView {
    func setData(_ categories: [Section<HappyMindCore.Category>]) {
        dataSource.setData(categories)
        collectionView.reloadData()
    }
}

extension CategoryViewController: CategoryDelegate {
    func didSelect(_ item: SubCategoryModel) {
        print("Item = \(item)")
    }
}
