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

    private let interactorModule: InteractorModule
    
    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }


    override func start() {
        let moduleInput = CategoryConfigurator.ModuleInput(coordinator: self,
                                                           interactorModule: interactorModule)
        let module = CategoryConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module)
    }
}

extension CategoryCoordinator: CategoryCoordinatorDelegate {

}
