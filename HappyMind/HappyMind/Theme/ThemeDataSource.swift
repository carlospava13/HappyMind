//
//  ThemeDataSource.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

protocol ThemeDataSourceDelegate: AnyObject {
    func didSelected(theme: Theme)
}

final class ThemeDataSource: GenericDataSource<ThemeCell, HappyMindCore.Theme> {
    
    weak var delegate: ThemeDataSourceDelegate?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theme = data[indexPath.section].data[indexPath.row]
        delegate?.didSelected(theme: theme)
    }
}
