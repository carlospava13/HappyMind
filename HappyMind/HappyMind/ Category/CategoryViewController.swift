//
//  CategoryViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class CategoryViewController: BaseListViewController {

    private var dataSource: CategoryDataSource = {
        CategoryDataSource(identifierCell: .categoryCell)
    }()

    private var ownPresenter: CategoryPresenterType! {
        presenter as? CategoryPresenterType
    }

    override func viewDidLoad() {
        ownPresenter?.bind(self)
        super.viewDidLoad()
        setupLogoutButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationTransparent(title: .localized(.happyMindTitle),
                                 backgroundColor: .white)
        setFontNavigationBar(font: UIFont.JosefinSansRegularFont(size: 30)!,
                             color: .orange())
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
    
    private func setupLogoutButton() {
        let button1 = UIBarButtonItem(image: UIImage(named: "logout"),
                                      style: .done,
                                      target: self,
                                      action: #selector(onLogout))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    @objc func onLogout() {
        ownPresenter.logOut()
    }
}

extension CategoryViewController: CategoryView {
    func setData(_ categories: [Section<HappyMindCore.Category>]) {
        dataSource.setData(categories)
        collectionView.reloadData()
    }
}

extension CategoryViewController: CategoryDelegate {
    func didSelect(_ item: HappyMindCore.Category) {
        ownPresenter.didSelect(item)
    }
    
    func welcome() {
        ownPresenter.goToWelcome()
    }
}
