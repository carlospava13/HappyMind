//
//  LoginCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol LoginFlowDelegate: AnyObject {
    func showCategoriesFromLogin()
}

protocol LoginCoordinatorDelegate: AnyObject {
    func showCategories()
    func showWelcomeFlow()
}

final class LoginCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule

    private var welcomeCoordinator: BaseCoordinator?
    private var categoryCoordinator: BaseCoordinator?

    weak var loginFlowDelegate: LoginFlowDelegate?

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

    func setWelcomeCoordinator() {
        let coordinator = WelcomeCoordinator(router: router,
            interactorModule: interactorModule)
        coordinator.loginConnectionDelegate = self
        addDependency(coordinator)
        coordinator.removeReferenceDelegete = self
        welcomeCoordinator = coordinator
    }

    func setCategoryCoordinator() {
        let coordinator = CategoryCoordinator(router: router,
            interactorModule: interactorModule)
        coordinator.removeReferenceDelegete = self
        addDependency(coordinator)
        categoryCoordinator = coordinator
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate, LoginConnectionDelegate {
    func showCategories() {
        router.dismissModule(animated: true, completion: {
            self.loginFlowDelegate?.showCategoriesFromLogin()
        })
    }

    func showWelcomeFlow() {
        router.dismissModule(animated: true, completion: {
            self.finishFlow?()
            self.setWelcomeCoordinator()
            self.welcomeCoordinator?.start()
        })
    }
}

extension LoginCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        welcomeCoordinator = nil
        categoryCoordinator = nil
    }
}
