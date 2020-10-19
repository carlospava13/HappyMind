//
//  GenericDataSource.swift
//  RapidApp
//
//  Created by Carlos Pava on 01/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SkeletonView
class GenericDataSource<Cell:BaseCollectionCell<T>, T>: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    SkeletonCollectionViewDataSource,
    SkeletonCollectionViewDelegate {

        var numberOfSkeletonRows: Int?
        private var skeletonCell: UICollectionViewCell.Type?
        private var identifierCell: String
        var data: [Section<T>] = []

        init(identifierCell: CollectionViewCellIdentifier = .defaultCell) {
            self.identifierCell = identifierCell.rawValue
        }

        func setData(_ data: [Section<T>]) {
            self.data = data
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return data.count
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data[section].data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! Cell
            cell.setData(data[indexPath.section].data[indexPath.row])
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }

        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }

        func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }

        func collectionView(_ collectionView: UICollectionView,
            viewForSupplementaryElementOfKind kind: String,
            at indexPath: IndexPath) -> UICollectionReusableView {
            UICollectionReusableView()
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize.zero
        }

        func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
            return CollectionViewCellIdentifier.categoryCell.rawValue
        }

        func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
        }
        func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
            return supplementaryViewIdentifierOfKind
        }
}
