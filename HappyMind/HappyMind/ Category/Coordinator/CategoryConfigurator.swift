//
//  CategoryConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class CategoryConfigurator {

    static func configure(moduleInput: CategoryConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = CategoryViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator, interactorModule: moduleInput.interactorModule)
        let presenter = CategoryPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: CategoryCoordinatorDelegate?,
                                           interactorModule: InteractorModule) -> CategoryPresenter.InputDependencies {
        return CategoryPresenter.InputDependencies(coordinator: coordinator,
                                                   getCategoriesInteractor: interactorModule.getCategoriesInteractor)
    }

    static func module(moduleInput: CategoryConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension CategoryConfigurator {
    struct ModuleInput {
        weak var coordinator: CategoryCoordinatorDelegate?
        let interactorModule: InteractorModule
    }
}
