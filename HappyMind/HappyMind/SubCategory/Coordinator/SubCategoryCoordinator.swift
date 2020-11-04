//
//  SubCategoryCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore
protocol SubCategoryCoordinatorDelegate: AnyObject {
    func showTheme(subcategory: HappyMindCore.SubCategory)
    func removeReference()
}

final class SubCategoryCoordinator: BaseCoordinator {

    private let interactorModule: InteractorModule
    private var themeCoordinator: ThemeCoordinator?

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }

    func start(category: HappyMindCore.Category) {
        let moduleInput = SubCategoryConfigurator.ModuleInput(coordinator: self,
            interactorModule: interactorModule, category: category)
        let module = SubCategoryConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }

    func setThemeCoodinator(subcategory: SubCategory) {
        let coordinator = ThemeCoordinator(router: router,
            interactorModule: interactorModule,
            subCategory: subcategory)
        addDependency(coordinator)
        themeCoordinator = coordinator
    }
}

extension SubCategoryCoordinator: SubCategoryCoordinatorDelegate {
    func removeReference() {
        removeReferenceDelegete?.removeReference(self)
    }
    
    func showTheme(subcategory: SubCategory) {
        setThemeCoodinator(subcategory: subcategory)
        themeCoordinator?.start()
    }
    
}
