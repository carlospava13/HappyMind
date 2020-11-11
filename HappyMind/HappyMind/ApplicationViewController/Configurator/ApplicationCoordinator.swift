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
    private var categoryCoordinator: BaseCoordinator?

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

    private func setLoginFlow() {
        let coordinator = LoginCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        coordinator.loginFlowDelegate = self
        loginCoordinator = coordinator
    }

    func setCategoryCoordinator() {
        let coordinator = CategoryCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        coordinator.categoryCoordinatorLoginDelegate = self
        categoryCoordinator = coordinator
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorDelegate {
    func showLogin() {
        setLoginFlow()
        loginCoordinator?.start()
    }

    func showCategories() {
        setCategoryCoordinator()
        categoryCoordinator?.start()
    }
}

extension ApplicationCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
    }
}

extension ApplicationCoordinator: LoginFlowDelegate {    
    func showCategoriesFromLogin() {
        setCategoryCoordinator()
        categoryCoordinator?.start()
        removeReference(loginCoordinator!)
        loginCoordinator = nil
    }
}

extension ApplicationCoordinator: CategoryCoordinatorLoginDelegate {
    func runLogin() {
        setLoginFlow()
        loginCoordinator?.start()
        removeReference(categoryCoordinator!)
        categoryCoordinator = nil
    }
}
