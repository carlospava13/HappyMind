//
//  WelcomeConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class WelcomeConfigurator {

    static func configure(moduleInput: WelcomeConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = WelcomeViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator, interactorModule: moduleInput.interactorModule)
        let presenter = WelcomePresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: WelcomeCoordinatorDelegate?, interactorModule: InteractorModule) -> WelcomePresenter.InputDependencies {
        return WelcomePresenter.InputDependencies(coordinator: coordinator, setFirstTimeInteractor: interactorModule.setFirstTimeInteractor)
    }

    static func module(moduleInput: WelcomeConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension WelcomeConfigurator {
    struct ModuleInput {
        weak var coordinator: WelcomeCoordinatorDelegate?
        let interactorModule: InteractorModule
    }
}
