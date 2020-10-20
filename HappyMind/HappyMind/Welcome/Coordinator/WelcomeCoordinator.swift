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
    func showPlayerViewController()
    func dismiss()
}

final class WelcomeCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule
    
    private var playerCoordinator: BaseCoordinator?
    weak var loginConnectionDelegate: LoginConnectionDelegate?

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
        setPlayerCoodinator()
    }
    
    override func start() {
        let moduleInput = WelcomeConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = WelcomeConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module)
    }
    
    func setPlayerCoodinator() {
        let playerCoordinator = AudioPlayerCoodinator(router: router, interactorModule: interactorModule)
        playerCoordinator.removeReferenceDelegete = self
        addDependency(playerCoordinator)
        self.playerCoordinator = playerCoordinator
    }
}

extension WelcomeCoordinator: WelcomeCoordinatorDelegate {
    func showPlayerViewController() {
        playerCoordinator?.start()
    }
    
    func dismiss() {
        router.dismissModule(animated: true) {
            self.loginConnectionDelegate?.showCategories()
        }
    }
}

extension WelcomeCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        switch coodinator {
        case is AudioPlayerCoodinator:
            playerCoordinator = nil
        default:
            break
        }
    }
}
