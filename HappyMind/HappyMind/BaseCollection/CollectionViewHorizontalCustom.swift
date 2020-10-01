//
//  CollectionViewHorizontalCustom.swift
//  RapidApp
//
//  Created by Carlos Pava on 01/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class CollectionViewHorizontalCustom: UICollectionViewFlowLayout {

    var display: CollectionDisplay = .grid {
        didSet {
            self.invalidateLayout()
        }
    }

    var height: CGFloat = 0.0 {
        willSet {
            configLayout()
        }
    }

    var width: CGFloat? = 0.0 {
        willSet {
            configLayout()
        }
    }

    init(display: CollectionDisplay) {
        super.init()
        self.display = display
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configLayout() {
        switch display {
        case .inline:
            scrollDirection = .horizontal
            if let width = width {
                itemSize = CGSize(width: width, height: height)
            }

        case .grid:
            scrollDirection = .vertical
            if let collectionView = collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                self.itemSize = CGSize(width: optimisedWidth, height: optimisedWidth) // keep as square
            }

        case .list:
            scrollDirection = .vertical
            if let collectionView = collectionView {
                itemSize = CGSize(width: collectionView.frame.width, height: height)
            }
        case .gridCuston(let height):
            scrollDirection = .horizontal
            if let collectionView = collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                self.itemSize = CGSize(width: height, height: height) // keep as square
            }
        }
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
