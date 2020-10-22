//
//  BaseListViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 21/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class BaseListViewController: BaseViewController {

    lazy var collectionView: CollectionView = {
        let collectionView = CollectionView(frame: .zero, layout: .list)
        collectionView.setHeight(120)
        collectionView.isSkeletonable = true
        return collectionView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setupConstraints()
        setupCollectionView()
        super.viewDidLoad()
    }

    private func setupConstraints() {
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guides.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            ])
    }

    private func setupCollectionView() {
        let identifierCell = CollectionViewCellIdentifier.categoryCell
        collectionView.register(CategoryCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
    }
}
