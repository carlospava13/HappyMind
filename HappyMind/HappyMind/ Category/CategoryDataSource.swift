//
//  CategoryDataSource.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

protocol CategoryDelegate: AnyObject {
    func didSelect(_ item: HappyMindCore.Category)
}

final class CategoryDataSource: GenericDataSource<CategoryCell, HappyMindCore.Category> {
    
    weak var categoryDelegate: CategoryDelegate?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        //cell.categoryCellDelegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = data[indexPath.section].data[indexPath.row]
        categoryDelegate?.didSelect(category)
    }
}
