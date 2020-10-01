//
//  CategoryConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class CategoryConfigurator {

    static func configure(moduleInput: CategoryConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = CategoryViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator)
        let presenter = CategoryPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: CategoryCoordinatorDelegate?) -> CategoryPresenter.InputDependencies {
        return CategoryPresenter.InputDependencies(coordinator: coordinator)
    }

    static func module(moduleInput: CategoryConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension CategoryConfigurator {
    struct ModuleInput {
        weak var coordinator: CategoryCoordinatorDelegate?
    }
}
