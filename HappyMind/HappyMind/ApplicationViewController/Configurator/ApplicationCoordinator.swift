//
//  ApplicationCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol ApplicationCoordinatorDelegate: AnyObject {
    func showLogin()
    func showCategories()
}

final class ApplicationCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule
    
    private var loginCoordinator: BaseCoordinator?

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
        setLoginFlow()
    }

    override func start() {
        let moduleInput = ApplicationConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = ApplicationConfigurator.module(moduleInput: moduleInput)
        finishFlow = {
            self.removeDependency(self)
        }
        router.setRootModule(module, hideBar: true, animated: false)
    }

    private func setLoginFlow()  {
        let coordinator = LoginCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        coordinator.removeReferenceDelegete = self
        loginCoordinator = coordinator
    }

    private func setCategories() -> BaseCoordinator {
        let coordinator = CategoryCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        return coordinator
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorDelegate {
    func showLogin() {
        loginCoordinator?.start()
    }

    func showCategories() {
        setCategories().start()
        finishFlow?()
    }
}

extension ApplicationCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        loginCoordinator = nil
    }
}
