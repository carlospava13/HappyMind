//
//  CategoryCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

protocol CategoryCoordinatorLoginDelegate: AnyObject {
    func runLogin()
}

protocol CategoryCoordinatorDelegate: AnyObject {
    func showSubCategories(category: HappyMindCore.Category)
    func showTheme(category: HappyMindCore.Category)
    func showWelcome()
    func showLogin()
}

final class CategoryCoordinator: BaseCoordinator {

    private let interactorModule: InteractorModule
    private var subCategoryCoordinator: SubCategoryCoordinator?
    private var welcomeCoordinator: WelcomeCoordinator?
    private var themeCoordinator: ThemeCoordinator?
    private var loginCoordinator: LoginCoordinator?
    weak var categoryCoordinatorLoginDelegate: CategoryCoordinatorLoginDelegate?

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

    func setSubCategoryCoodinator() {
        let coordinator = SubCategoryCoordinator(router: router, interactorModule: interactorModule)
        coordinator.removeReferenceDelegete = self
        addDependency(coordinator)
        subCategoryCoordinator = coordinator
    }

    func setThemeCoodinator(category: HappyMindCore.Category) {
        let coordinator = ThemeCoordinator(router: router,
            interactorModule: interactorModule,
            name: category.name,
            id: category.id)
        addDependency(coordinator)
        themeCoordinator = coordinator
    }

    func setWelcomeCoodinator() {
        let coordinator = WelcomeCoordinator(router: router,
            interactorModule: interactorModule)
        coordinator.removeReferenceDelegete = self
        addDependency(coordinator)
        welcomeCoordinator = coordinator
    }
}

extension CategoryCoordinator: CategoryCoordinatorDelegate {
    func showTheme(category: HappyMindCore.Category) {
        setThemeCoodinator(category: category)
        themeCoordinator?.start()
    }

    func showSubCategories(category: HappyMindCore.Category) {
        setSubCategoryCoodinator()
        subCategoryCoordinator?.start(category: category)
    }

    func showWelcome() {
        setWelcomeCoodinator()
        welcomeCoordinator?.navigateStart()
    }
    
    func showLogin() {
        router.dismissModule(animated: true) {
            self.categoryCoordinatorLoginDelegate?.runLogin()
            //self.loginCoordinator?.start()
            //self.finishFlow?()
        }
    }
}

extension CategoryCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        subCategoryCoordinator = nil
        welcomeCoordinator = nil
    }
}
