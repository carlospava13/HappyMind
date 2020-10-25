//
//  CategoryCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol CategoryCoordinatorDelegate: AnyObject {
    func showSubCategories(categoryId: String)
}

final class CategoryCoordinator: BaseCoordinator {

    private let interactorModule: InteractorModule
    private var subCategoryCoordinator: SubCategoryCoordinator?

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
        setSubCategoryCoodinator()
    }

    override func start() {
        let moduleInput = CategoryConfigurator.ModuleInput(coordinator: self,
            interactorModule: interactorModule)
        let module = CategoryConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module)
    }
    
    func setSubCategoryCoodinator() {
        let coordinator = SubCategoryCoordinator(router: router, interactorModule: interactorModule)
        addDependency(coordinator)
        subCategoryCoordinator = coordinator
    }
}

extension CategoryCoordinator: CategoryCoordinatorDelegate {
    func showSubCategories(categoryId: String) {
        subCategoryCoordinator?.start(categoryId: categoryId)
    }
}
