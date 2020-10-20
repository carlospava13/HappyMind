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

    private lazy var welcomeCoordinator: BaseCoordinator = {
        let coordinator = WelcomeCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        return coordinator
    }()

    private lazy var categoryCoordinator: BaseCoordinator = {
        let coordinator = CategoryCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        return coordinator
    }()

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
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    func showCategories() {
        router.dismissModule(animated: true, completion: {
            self.finishFlow?()
            self.categoryCoordinator.start()
        })
    }

    func showWelcomeFlow() {
        router.dismissModule(animated: true, completion: {
            self.finishFlow?()
            self.welcomeCoordinator.start()
        })
    }
}

extension LoginCoordinator: CategoryCoordinatorDelegate {

}

extension LoginCoordinator: WelcomeCoordinatorDelegate {
    func showPlayerViewController() {

    }
}
