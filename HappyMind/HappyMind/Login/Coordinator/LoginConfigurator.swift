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
            coordinator: moduleInput.coordinator, interactorModule: moduleInput.interactorModule)
        let presenter = LoginPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: LoginCoordinatorDelegate?, interactorModule: InteractorModule) -> LoginPresenter.InputDependencies {
        return LoginPresenter.InputDependencies(coordinator: coordinator, loginInteractor: interactorModule.loginInteractor)
    }

    static func module(moduleInput: LoginConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension LoginConfigurator {
    struct ModuleInput {
        weak var coordinator: LoginCoordinatorDelegate?
        let interactorModule: InteractorModule
    }
}
