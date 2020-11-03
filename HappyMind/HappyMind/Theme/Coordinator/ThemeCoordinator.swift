//
//  ThemeCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

protocol ThemeCoordinatorDelegate: AnyObject {
    func showAudioPlayer(theme: Theme)
    func showVideoPlayer(theme: Theme)
}

final class ThemeCoordinator: BaseCoordinator {

    private let interactorModule: InteractorModule
    private let subCategory: HappyMindCore.SubCategory
    private var playerCoordinator: BaseCoordinator?
    private var videoPlayerCoordinator: BaseCoordinator?

    init(router: RouterType,
        interactorModule: InteractorModule,
        subCategory: HappyMindCore.SubCategory) {
        self.interactorModule = interactorModule
        self.subCategory = subCategory
        super.init(router: router)
    }

    override func start() {
        let moduleInput = ThemeConfigurator.ModuleInput(coordinator: self,
            interactorModule: interactorModule,
            subCategory: subCategory)
        let module = ThemeConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }

    func setPlayerCoodinator(theme: Theme) {
        let playerCoordinator = AudioPlayerCoodinator(router: router, interactorModule: interactorModule,
            theme: theme)
//        playerCoordinator.removeReferenceDelegete = self
        addDependency(playerCoordinator)
        self.playerCoordinator = playerCoordinator
    }

    private func setVideoPlayerCoordinator(theme: Theme) {
        let coordinator = VideoPlayerCoordinator(router: router, theme: theme)
        coordinator.removeReferenceDelegete = self
        addDependency(coordinator)
        videoPlayerCoordinator = coordinator
    }
}

extension ThemeCoordinator: ThemeCoordinatorDelegate {
    func showAudioPlayer(theme: Theme) {
        setPlayerCoodinator(theme: theme)
        playerCoordinator?.start()
    }
    
    func showVideoPlayer(theme: Theme) {
        setVideoPlayerCoordinator(theme: theme)
        videoPlayerCoordinator?.start()
    }
}

extension ThemeCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        videoPlayerCoordinator = nil
    }
}
