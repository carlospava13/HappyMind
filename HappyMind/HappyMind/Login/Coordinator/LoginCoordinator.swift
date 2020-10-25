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

    private var welcomeCoordinator: BaseCoordinator?
    private var categoryCoordinator: BaseCoordinator?

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
        setWelcomeCoordinator()
        setCategoryCoordinator()
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
        addDependency(coordinator)
        categoryCoordinator = coordinator
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate, LoginConnectionDelegate {
    func showCategories() {
        router.dismissModule(animated: true, completion: {
            self.categoryCoordinator?.start()
            self.removeReferenceDelegete?.removeReference(self)
        })
    }

    func showWelcomeFlow() {
        router.dismissModule(animated: true, completion: {
            self.finishFlow?()
            self.welcomeCoordinator?.start()
        })
    }
}

extension LoginCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        welcomeCoordinator = nil
    }
}
