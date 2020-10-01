//
//  CategoryModel.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

struct CategoryModel {
    let title: String
    let subcategories: Section<SubCategoryModel>
}

struct SubCategoryModel {
    let name: String
    let image: UIImage
}
