//
//  WelcomeContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol WelcomeView: BaseView {
    func setData(_ welcomeList: [Section<WelcomeObject>])
    func showSkeleton()
    func hideSkeleton()
}

protocol WelcomePresenterType: BasePresenterType {
    func didSelected()
}
