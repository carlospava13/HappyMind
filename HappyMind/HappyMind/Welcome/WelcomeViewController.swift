//
//  WelcomeViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class WelcomeViewController: BaseListViewController {

    private lazy var dataSource: WelcomeDataSource = {
        WelcomeDataSource(identifierCell: .categoryCell)
    }()

    private var ownPresenter: WelcomePresenterType! {
        presenter as? WelcomePresenterType
    }

    override func viewDidLoad() {
        ownPresenter?.bind(self)
        super.viewDidLoad()
        setFontNavigationBar(font: UIFont.calibriBoldFont(size: 28)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationTransparent(title: .localized(.welcome), backgroundColor: .orange())
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupSkipButton() {
        let skipButton = UIButton(type: .custom)
        skipButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        skipButton.setTitle(.localized(.skip), for: .normal)
        skipButton.titleLabel?.font = UIFont.calibriRegularFont()
        skipButton.addTarget(self, action: #selector(onSkip), for: .touchUpInside)
        skipButton.titleLabel?.textColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
    }


    override func setupCollectionView() {
        super.setupCollectionView()
        let identifierCell = CollectionViewCellIdentifier.categoryCell
        collectionView.register(WelcomeCell.self,
            forCellWithReuseIdentifier: identifierCell.rawValue)
        collectionView.register(WelcomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WelcomeHeader")
        dataSource.delegate = self
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    @objc func onSkip() {
        ownPresenter.skip()
    }
}

extension WelcomeViewController: WelcomeView {
    func set(hiddeSkip: Bool) {
        if hiddeSkip {
            setBackButtonItem(tintColor: .white)
        } else {
            setupSkipButton()
        }
    }
    
    func setData(_ welcomeList: [Section<Theme>]) {
        dataSource.setData(welcomeList)
        collectionView.reloadData()
    }
}

extension WelcomeViewController: WelcomeDataSourceDelegate {
    func didSelected(theme: Theme) {
        ownPresenter.didSelected(theme)
    }
}
