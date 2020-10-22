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
        collectionView.setHeight(95)
        return collectionView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupCollectionView()
        setupConstraints()
        super.viewDidLoad()
    }

    private func setupConstraints() {
        view.addSubview(collectionView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guides.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            ])
    }

    func setupCollectionView() {
        collectionView.isSkeletonable = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
    }

    override func showSkeleton() {
        collectionView.showAnimatedGradientSkeleton()
    }

    override func hideSkeleton() {
        collectionView.hideSkeleton()
    }
}
