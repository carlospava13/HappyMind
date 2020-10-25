//
//  SubCategoryConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class SubCategoryConfigurator {

    static func configure(moduleInput: SubCategoryConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = SubCategoryViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator,
            interactorModule: moduleInput.interactorModule,
            categoryId: moduleInput.categoryId)
        let presenter = SubCategoryPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: SubCategoryCoordinatorDelegate?,
                                           interactorModule: InteractorModule,
                                           categoryId: String) -> SubCategoryPresenter.InputDependencies {
        return SubCategoryPresenter.InputDependencies(coordinator: coordinator, getSubCatogoryInteractor: interactorModule.getSubCatogoryInteractor,
                                                      categoryId: categoryId)
    }

    static func module(moduleInput: SubCategoryConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension SubCategoryConfigurator {
    struct ModuleInput {
        weak var coordinator: SubCategoryCoordinatorDelegate?
        let interactorModule: InteractorModule
        let categoryId: String
    }
}
