//
//  WelcomeContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore
protocol WelcomeView: BaseView {
    func setData(_ welcomeList: [Section<Theme>])
}

protocol WelcomePresenterType: BasePresenterType {
    func didSelected(_ theme: Theme)
    func skip()
}
