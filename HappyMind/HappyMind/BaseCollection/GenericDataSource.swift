//
//  GenericDataSource.swift
//  RapidApp
//
//  Created by Carlos Pava on 01/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class GenericDataSource<Cell:BaseCollectionCell<T>, T>: GenericDinamic<T>, UICollectionViewDataSource, UICollectionViewDelegate {

    private var identifierCell: String

    init(identifierCell: CollectionViewCellIdentifier = .defaultCell) {
        self.identifierCell = identifierCell.rawValue
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! Cell
        cell.setData(data.value[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as? Cell else {
//            return UICollectionViewCell()
//        }
//        return cell
//    }
}
