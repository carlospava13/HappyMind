//
//  ThemeViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
final class ThemeViewController: BaseListViewController {

    private var dataSource: ThemeDataSource = {
        ThemeDataSource(identifierCell: .categoryCell)
    }()

    private var onwPresenter: ThemePresenterType! {
        presenter as? ThemePresenterType
    }

    private var titleNav: String? {
        didSet {
            setNavigationTransparent(title: oldValue, backgroundColor: .white)
        }
    }

    override func viewDidLoad() {
        onwPresenter.bind(self)
        setBackButtonItem(tintColor: .gray)
        super.viewDidLoad()
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
        collectionView.register(ThemeCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.delegate = self
    }

}

extension ThemeViewController: ThemeView {
    func set(title: String) {
        self.titleNav = title
    }

    func setData(_ themes: [Section<Theme>]) {
        dataSource.setData(themes)
        collectionView.reloadData()
    }
}

extension ThemeViewController: ThemeDataSourceDelegate {
    func didSelected(theme: Theme) {
        onwPresenter.didSelected(theme: theme)
    }
}
