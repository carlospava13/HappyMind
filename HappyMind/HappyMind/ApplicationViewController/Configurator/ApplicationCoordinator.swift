//
//  ApplicationCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol ApplicationCoordinatorDelegate: AnyObject {

}

final class ApplicationCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }

    override func start() {
        let moduleInput = ApplicationConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = ApplicationConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module, hideBar: true, animated: false)
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorDelegate {

}
