//
//  WelcomeViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView
final class WelcomeViewController: BaseViewController {

    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView(frame: .zero, layout: .list)
        collectionView.setHeight(90)
        collectionView.isSkeletonable = true
        return collectionView
    }()

    private lazy var dataSource: WelcomeDataSource = {
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
        setNavigationTransparent(title: .localized(.welcome), backgroundColor: .orange(), textColor: .white)
        setupSkipButton()
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupSkipButton() {
        let skipButton = UIButton(type: .custom)
        skipButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        skipButton.setTitle(.localized(.skip), for: .normal)
        skipButton.titleLabel?.font = UIFont.calibriFont()
        skipButton.addTarget(self, action: #selector(onSkip), for: .touchUpInside)
        skipButton.titleLabel?.textColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
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
        dataSource.delegate = self
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    @objc func onSkip() {
        ownPresenter.skip()
    }
}

extension WelcomeViewController: WelcomeView {
    func showSkeleton() {
        collectionView.showAnimatedGradientSkeleton()
    }

    func hideSkeleton() {
        collectionView.hideSkeleton()
    }

    func setData(_ welcomeList: [Section<WelcomeObject>]) {
        dataSource.setData(welcomeList)
        collectionView.reloadData()
    }
}

extension WelcomeViewController: WelcomeDataSourceDelegate {
    func didSelected(welcome: WelcomeObject) {
        ownPresenter.didSelected()
    }
}
