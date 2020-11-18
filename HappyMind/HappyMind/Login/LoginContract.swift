//
//  LoginContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol LoginPresenterType: BasePresenterType {
    func setLogin(email: String, password: String)
}

protocol LoginView: BaseView {
    func showLoading()
    func hideLoading()
}
