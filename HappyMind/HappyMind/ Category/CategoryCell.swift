//
//  CategoryCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
import SDWebImage

final class CategoryCell: GenericCell<HappyMindCore.Category> {
    override func setData(_ data: HappyMindCore.Category) {
        nameCategoryLabel.text = data.name
    }
}
