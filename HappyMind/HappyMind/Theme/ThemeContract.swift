//
//  ThemeContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore
protocol ThemeView: BaseView {
    func set(title: String)
    func setData(_ themes: [Section<HappyMindCore.Theme>])
}

protocol ThemePresenterType: BasePresenterType {
    func didSelected(theme: Theme) 
}
