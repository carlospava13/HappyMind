//
//  ThemeConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class ThemeConfigurator {

    static func configure(moduleInput: ThemeConfigurator.ModuleInput) -> UIViewController {

        let themeViewController = ThemeViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator,
            interactorModule: moduleInput.interactorModule,
            name: moduleInput.name,
            id: moduleInput.id)
        let presenter = ThemePresenter(inputDependencies: dependencies)
        themeViewController.presenter = presenter
        return themeViewController
    }

    private static func createDependencies(coordinator: ThemeCoordinatorDelegate?,
        interactorModule: InteractorModule,
        name: String,
        id: String) -> ThemePresenter.InputDependencies {
        return ThemePresenter.InputDependencies(coordinator: coordinator,
            getThemeInteractor: interactorModule.getThemeInteractor,
            name: name,
            id: id)
    }

    static func module(moduleInput: ThemeConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension ThemeConfigurator {
    struct ModuleInput {
        let coordinator: ThemeCoordinatorDelegate?
        let interactorModule: InteractorModule
        let name: String
        let id: String
    }
}
