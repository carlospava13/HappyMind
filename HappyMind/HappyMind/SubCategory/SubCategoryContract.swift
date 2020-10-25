//
//  SubCategoryContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

protocol SubCategoryPresenterType: BasePresenterType {

}

protocol SubCategoryView: BaseView {
    func setData(_ subcategories: [Section<HappyMindCore.SubCategory>])
}
