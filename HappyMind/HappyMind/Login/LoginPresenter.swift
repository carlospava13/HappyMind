//
//  LoginPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

final class LoginPresenter: BasePresenter {
    
    struct InputDependencies {
        weak var coordinator: LoginCoordinatorDelegate?
    }
    
    private let inputDependencies: InputDependencies
    
    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }
}

extension LoginPresenter: LoginPresenterType {
    func setLogin() {
        inputDependencies.coordinator?.showCategories()
    }
}
