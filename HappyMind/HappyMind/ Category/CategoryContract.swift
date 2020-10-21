//
//  CategoryContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore
protocol CategoryPresenterType: BasePresenterType {
 
}

protocol CategoryView: BaseView {
    func setData(_ categories: [Section<HappyMindCore.Category>])
    func showSkeleton()
    func hideSkeleton()
}
