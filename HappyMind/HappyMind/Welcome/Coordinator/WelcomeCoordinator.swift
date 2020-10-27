//
//  WelcomeCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol LoginConnectionDelegate: AnyObject {
    func showCategories()
}

protocol WelcomeCoordinatorDelegate: AnyObject {
    func dismiss()
    func showVideo()
}

final class WelcomeCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule
    weak var loginConnectionDelegate: LoginConnectionDelegate?

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
    func dismiss() {
        router.dismissModule(animated: true) {
            self.loginConnectionDelegate?.showCategories()
        }
    }
    
    func showVideo() {
        VideoPlayerCoordinator(router: router).start()
    }
}

extension WelcomeCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
    }
}
