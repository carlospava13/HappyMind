//
//  LoginPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

final class LoginPresenter: BasePresenter {
    
    struct InputDependencies {
        weak var coordinator: LoginCoordinatorDelegate?
        let loginInteractor: LoginInteractor
    }
    
    private let inputDependencies: InputDependencies
    
    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }
}

extension LoginPresenter: LoginPresenterType {
    func setLogin(email: String, password: String) {
        inputDependencies.loginInteractor.execute(LoginParams(email: email.lowercased(), password: password)).sink(receiveCompletion: { (completion) in
            print(completion)
        }) { (user) in
            print(user)
        }.store(in: &subscriptions)
    }
}
