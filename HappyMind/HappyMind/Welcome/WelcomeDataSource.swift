//
//  WelcomeDataSource.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

protocol WelcomeDataSourceDelegate: AnyObject {
    func didSelected(theme: Theme)
}

final class WelcomeDataSource: GenericDataSource<WelcomeCell, Theme> {

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
            return UICollectionReusableView()
        }
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
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected(theme: data[indexPath.section].data[indexPath.row])
    }
}
