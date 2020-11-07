//
//  WelcomeCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

protocol LoginConnectionDelegate: AnyObject {
    func showCategories()
}

protocol WelcomeCoordinatorDelegate: AnyObject {
    func dismiss()
    func showAudio(theme: Theme)
    func showVideo(theme: Theme)
    func showTextDetail(theme: Theme)
}

final class WelcomeCoordinator: BaseCoordinator {
    private let interactorModule: InteractorModule
    private var playerCoordinator: BaseCoordinator?
    private var videoPlayerCoordinator: BaseCoordinator?
    private var textDetailCoordinator: TextDetailCoordinator?
    weak var loginConnectionDelegate: LoginConnectionDelegate?

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }

    override func start() {
        let moduleInput = WelcomeConfigurator.ModuleInput(coordinator: self,
                                                          interactorModule: interactorModule,
                                                          hiddeSkip: false)
        let module = WelcomeConfigurator.module(moduleInput: moduleInput)
        router.setRootModule(module)
    }
    
    func navigateStart() {
        let moduleInput = WelcomeConfigurator.ModuleInput(coordinator: self,
                                                          interactorModule: interactorModule,
                                                          hiddeSkip: true)
        let module = WelcomeConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }

    private func setAudioPlayerCoodinator(theme: Theme) {
        let playerCoordinator = AudioPlayerCoodinator(router: router, interactorModule: interactorModule,
            theme: theme)
        playerCoordinator.removeReferenceDelegete = self
        addDependency(playerCoordinator)
        self.playerCoordinator = playerCoordinator
    }
    
    private func setVideoPlayerCoordinator(theme: Theme) {
        let coordinator = VideoPlayerCoordinator(router: router, theme: theme)
        coordinator.removeReferenceDelegete = self
        addDependency(coordinator)
        videoPlayerCoordinator = coordinator
    }
    
    private func setTextDetailCoordinator(theme: Theme) {
        let coordinator = TextDetailCoordinator(router: router)
        coordinator.removeReferenceDelegete = self
        addDependency(coordinator)
        textDetailCoordinator = coordinator
    }
    
}

extension WelcomeCoordinator: WelcomeCoordinatorDelegate {
    func dismiss() {
        router.dismissModule(animated: true) {
            self.loginConnectionDelegate?.showCategories()
        }
    }
    
    func showAudio(theme: Theme) {
        setAudioPlayerCoodinator(theme: theme)
        playerCoordinator?.start()
    }

    func showVideo(theme: Theme) {
        setVideoPlayerCoordinator(theme: theme)
        videoPlayerCoordinator?.start()
    }
    
    func showTextDetail(theme: Theme) {
        setTextDetailCoordinator(theme: theme)
        textDetailCoordinator?.start(theme: theme)
    }
}

extension WelcomeCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        playerCoordinator = nil
        videoPlayerCoordinator = nil
        textDetailCoordinator = nil
    }
}
