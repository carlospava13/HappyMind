//
//  SubCategoryConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
final class SubCategoryConfigurator {

    static func configure(moduleInput: SubCategoryConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = SubCategoryViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator,
            interactorModule: moduleInput.interactorModule,
            category: moduleInput.category)
        let presenter = SubCategoryPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: SubCategoryCoordinatorDelegate?,
                                           interactorModule: InteractorModule,
                                           category: HappyMindCore.Category) -> SubCategoryPresenter.InputDependencies {
        return SubCategoryPresenter.InputDependencies(coordinator: coordinator, getSubCatogoryInteractor: interactorModule.getSubCatogoryInteractor,
                                                      category: category)
    }

    static func module(moduleInput: SubCategoryConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension SubCategoryConfigurator {
    struct ModuleInput {
        weak var coordinator: SubCategoryCoordinatorDelegate?
        let interactorModule: InteractorModule
        let category: HappyMindCore.Category
    }
}
