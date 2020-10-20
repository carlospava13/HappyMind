//
//  ApplicationConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class ApplicationConfigurator {

    static func configure(moduleInput: ApplicationConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = ApplicationViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator, interactorModule: moduleInput.interactorModule)
        let presenter = ApplicationPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: ApplicationCoordinatorDelegate?, interactorModule: InteractorModule) -> ApplicationPresenter.InputDependencies {
        return ApplicationPresenter.InputDependencies(coordinator: coordinator,
                                                      firstTimeInteractor: interactorModule.firstTimeInteractor)
    }

    static func module(moduleInput: ApplicationConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension ApplicationConfigurator {
    struct ModuleInput {
        weak var coordinator: ApplicationCoordinatorDelegate?
        let interactorModule: InteractorModule
    }
}
