//
//  SubCategoryViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
final class SubCategoryViewController: BaseListViewController {

    private lazy var dataSource: SubCategoryDataSource = {
        let dataSource = SubCategoryDataSource(identifierCell: .categoryCell)
        dataSource.subCategoryDelegate = self
        return dataSource
    }()

    private var ownPresenter: SubCategoryPresenterType! {
        presenter as? SubCategoryPresenterType
    }

    override func viewDidLoad() {
        ownPresenter.bind(self)
        super.viewDidLoad()
    }

    override func setupCollectionView() {
        super.setupCollectionView()
        let identifierCell = CollectionViewCellIdentifier.categoryCell
        collectionView.register(SubCategoryCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
}

extension SubCategoryViewController: SubCategoryView {
    func set(title: String) {
        self.title = title
    }
    
    func setData(_ subcategories: [Section<HappyMindCore.SubCategory>]) {
        dataSource.setData(subcategories)
        collectionView.reloadData()
    }
}

extension SubCategoryViewController: SubCategoryDelegate {
    func didSelect(_ item: SubCategory) {
        ownPresenter.didSelected(subcategory: item)
    }
}
