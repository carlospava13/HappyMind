//
//  GenericDataSource.swift
//  RapidApp
//
//  Created by Carlos Pava on 01/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class GenericDataSource<Cell:BaseCollectionCell<T>, T>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var identifierCell: String
    private var data: [Section<T>] = [] 

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
}
