//
//  SubCategoryDataSource.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

protocol SubCategoryDelegate: AnyObject  {
    func didSelect(_ item: HappyMindCore.SubCategory)
}

final class SubCategoryDataSource: GenericDataSource<SubCategoryCell, HappyMindCore.SubCategory> {

    weak var subCategoryDelegate: SubCategoryDelegate?

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        subCategoryDelegate?.didSelect(data[indexPath.section].data[indexPath.row])
    }
}
