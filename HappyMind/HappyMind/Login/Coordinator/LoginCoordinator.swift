//
//  LoginCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func showCategories()
    func showWelcomeFlow()
}

final class LoginCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }

    override func start() {
        let moduleInput = LoginConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = LoginConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module, hideBar: true, animated: false)
    }

    private func setCategories() {
        let moduleInput = CategoryConfigurator.ModuleInput(coordinator: self,
            interactorModule: interactorModule)
        let module = CategoryConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module)
    }

    private func setWelcomeFlow() {
        let moduleInput = WelcomeConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = WelcomeConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module, hideBar: false, animated: true)
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    func showCategories() {
        router.dismissModule(animated: true, completion: {
            self.finishFlow?()
            self.setCategories()
        })
    }

    func showWelcomeFlow() {
        router.dismissModule(animated: true, completion: {
            self.finishFlow?()
            self.setWelcomeFlow()
        })
    }
}

extension LoginCoordinator: CategoryCoordinatorDelegate {

}

extension LoginCoordinator: WelcomeCoordinatorDelegate {

}
