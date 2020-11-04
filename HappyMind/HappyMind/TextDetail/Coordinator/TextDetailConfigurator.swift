//
//  TextDetailConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation


import UIKit
import HappyMindCore

final class TextDetailConfigurator {

    static func configure(moduleInput: TextDetailConfigurator.ModuleInput) -> UIViewController {

        let textDetailViewController = TextDetailViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator)
        let presenter = TextDetailPresenter(inputDependencies: dependencies)
        textDetailViewController.presenter = presenter
        return textDetailViewController
    }

    private static func createDependencies(coordinator: TextDetailCoordinatorDelegate?) -> TextDetailPresenter.InputDependencies {
        return TextDetailPresenter.InputDependencies(coordinator: coordinator)
    }

    static func module(moduleInput: TextDetailConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension TextDetailConfigurator {
    struct ModuleInput {
        let coordinator: TextDetailCoordinatorDelegate?
    }
}
