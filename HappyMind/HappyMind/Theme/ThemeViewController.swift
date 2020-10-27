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

    override func viewDidLoad() {
        setNavigationTransparent(title: .localized(.happyMindTitle),
            backgroundColor: .white)
        setFontNavigationBar(font: UIFont.JosefinSansRegularFont(size: 30)!,
            color: .orange())
        setupCollectionView()
        onwPresenter.bind(self)
        super.viewDidLoad()
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
        self.title = title
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
