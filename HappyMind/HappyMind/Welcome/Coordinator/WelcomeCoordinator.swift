//
//  WelcomeCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol WelcomeCoordinatorDelegate: AnyObject {
    
}

final class WelcomeCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }
    
    override func start() {
        let moduleInput = WelcomeConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = WelcomeConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module)
    }
}

extension WelcomeCoordinator: WelcomeCoordinatorDelegate {
    
}
