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
    
    private var ownView: LoginView! {
        view as? LoginView
    }
    
    private let inputDependencies: InputDependencies
    
    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }
}

extension LoginPresenter: LoginPresenterType {
    func setLogin(email: String, password: String) {
        inputDependencies.loginInteractor.execute(LoginParams(email: email.lowercased(), password: password)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                self.ownView.show(error)
            case .finished:
                self.inputDependencies.coordinator?.showWelcomeFlow()
            }
        }) { (user) in
            print(user)
        }.store(in: &subscriptions)
    }
}
