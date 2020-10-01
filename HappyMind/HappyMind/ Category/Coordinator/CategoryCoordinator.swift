//
//  CategoryCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol CategoryCoordinatorDelegate: AnyObject {

}

final class CategoryCoordinator: BaseCoordinator {
    override func start() {
        let moduleInput = CategoryConfigurator.ModuleInput(coordinator: self)
        let module = CategoryConfigurator.module(moduleInput: moduleInput)
        router.present(module, animated: false)
    }
}

extension CategoryCoordinator: CategoryCoordinatorDelegate {

}
