//
//  WelcomeViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class WelcomeViewController: BaseViewController {

    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView(frame: .zero, layout: .list)
        collectionView.setHeight(90)
        return collectionView
    }()

    private var dataSource: WelcomeDataSource = {
        WelcomeDataSource(identifierCell: .categoryCell)
    }()

    private var ownPresenter: WelcomePresenterType! {
        presenter as? WelcomePresenterType
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        ownPresenter?.bind(self)
        setupConstraints()
        setupCollectionView()
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
        collectionView.register(WelcomeCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.register(WelcomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WelcomeHeader")
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
}

extension WelcomeViewController: WelcomeView {
    func setData(_ welcomeList: [Section<WelcomeObject>]) {
        dataSource.setData(welcomeList)
        collectionView.reloadData()
    }
}
