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
        let firstTimeInteractor: FirstTimeInteractor
    }

    private var ownView: LoginView! {
        view as? LoginView
    }

    private let inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    private func isFirtsTimeInteractor() {
        inputDependencies.firstTimeInteractor.execute(nil).sink { [weak self] (completion) in
            switch completion {
            case .failure:
                self?.inputDependencies.coordinator?.showWelcomeFlow()
            case .finished:
                self?.inputDependencies.coordinator?.showCategories()
            }
        } receiveValue: { (value) in
        }.store(in: &subscriptions)
    }
}

extension LoginPresenter: LoginPresenterType {
    func setLogin(email: String, password: String) {
        inputDependencies.loginInteractor.execute(
            LoginParams(email: email.lowercased(),
                password: password)
        ).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.ownView.show(CustomError.notLogin.rawValue)
            case .finished:
                self.isFirtsTimeInteractor()
            }
        }) { (user) in
            print(user)
        }.store(in: &subscriptions)
    }
}
