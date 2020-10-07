//
//  LoginConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class LoginConfigurator {

    static func configure(moduleInput: LoginConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = LoginViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator)
        let presenter = LoginPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: LoginCoordinatorDelegate?) -> LoginPresenter.InputDependencies {
        return LoginPresenter.InputDependencies(coordinator: coordinator)
    }

    static func module(moduleInput: LoginConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension LoginConfigurator {
    struct ModuleInput {
        weak var coordinator: LoginCoordinatorDelegate?
    }
}
