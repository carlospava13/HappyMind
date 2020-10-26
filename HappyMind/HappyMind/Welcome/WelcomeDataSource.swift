//
//  WelcomeDataSource.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView

protocol WelcomeDataSourceDelegate: AnyObject {
    func didSelected(welcome: WelcomeObject)
    func showVideo()
}

final class WelcomeDataSource: GenericDataSource<WelcomeCell, WelcomeObject> {

    weak var delegate: WelcomeDataSourceDelegate?

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WelcomeHeader", for: indexPath) as! WelcomeHeader

            if data.count > 0,
                let title = data[indexPath.section].title {
                headerView.set(title: title)
            }

            return headerView

        default:
            assert(false, "Unexpected element kind")
        }
    }

    override func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return "WelcomeHeader"
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        if data.isEmpty {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel)
        }
    }

    override func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        CollectionViewCellIdentifier.categoryCell.rawValue
    }

    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            delegate?.showVideo()
        } else {
            delegate?.didSelected(welcome: data[indexPath.section].data[indexPath.row])
        }
    }
}
