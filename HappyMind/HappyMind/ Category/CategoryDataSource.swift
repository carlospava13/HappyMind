//
//  CategoryDataSource.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol CategoryDelegate: AnyObject {
    func didSelect(_ item: SubCategoryModel)
}

final class CategoryDataSource: GenericDataSource<CategoryCell, CategoryModel> {
    
    weak var categoryDelegate: CategoryDelegate?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.categoryCellDelegate = self
        return cell
    }
}

extension CategoryDataSource: CategoryCellDelegate {
    func didSelect(_ item: SubCategoryModel) {
         categoryDelegate?.didSelect(item)
    }
}
