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

    private var titleNav: String? {
        didSet {
            setNavigationTransparent(title: oldValue, backgroundColor: .white)
        }
    }

    override func viewDidLoad() {
        ownPresenter.bind(self)
        super.viewDidLoad()
        setBackButtonItem(tintColor: .gray)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationTransparent(title: titleNav, backgroundColor: .white)
        setFontNavigationBar(font: UIFont.JosefinSansRegularFont(size: 25)!,
            color: .orange())
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
        self.titleNav = title
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
