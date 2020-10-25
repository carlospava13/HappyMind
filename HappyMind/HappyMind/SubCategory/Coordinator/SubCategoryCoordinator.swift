//
//  SubCategoryCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol SubCategoryCoordinatorDelegate: AnyObject {

}

final class SubCategoryCoordinator: BaseCoordinator {

    private let interactorModule: InteractorModule

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }

    func start(categoryId: String) {
        let moduleInput = SubCategoryConfigurator.ModuleInput(coordinator: self,
            interactorModule: interactorModule, categoryId: categoryId)
        let module = SubCategoryConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }
}

extension SubCategoryCoordinator: SubCategoryCoordinatorDelegate {

}
