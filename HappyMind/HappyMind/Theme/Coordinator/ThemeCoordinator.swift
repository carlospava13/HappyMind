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
    func showTextDetail(theme: Theme)
    func removeReference()
}

final class ThemeCoordinator: BaseCoordinator {

    private let interactorModule: InteractorModule
    private var playerCoordinator: BaseCoordinator?
    private var videoPlayerCoordinator: BaseCoordinator?
    private var textDetailCoordinator: TextDetailCoordinator?
    
    private var name: String!
    private var id: String!

    init(router: RouterType,
        interactorModule: InteractorModule,
        name: String,
        id: String) {
        self.interactorModule = interactorModule
        self.name = name
        self.id = id
        super.init(router: router)
    }

    override func start() {
        let moduleInput = ThemeConfigurator.ModuleInput(coordinator: self,
            interactorModule: interactorModule,
            name: name,
            id: id)
        let module = ThemeConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }

    func setPlayerCoodinator(theme: Theme) {
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

extension ThemeCoordinator: ThemeCoordinatorDelegate {
    func showAudioPlayer(theme: Theme) {
        setPlayerCoodinator(theme: theme)
        playerCoordinator?.start()
    }
    
    func showVideoPlayer(theme: Theme) {
        setVideoPlayerCoordinator(theme: theme)
        videoPlayerCoordinator?.start()
    }
    
    func showTextDetail(theme: Theme) {
        setTextDetailCoordinator(theme: theme)
        textDetailCoordinator?.start(theme: theme)
    }
    
    func removeReference() {
        removeReferenceDelegete?.removeReference(self)
    }
}

extension ThemeCoordinator: RemoveReferenceDelegate {
    func removeReference(_ coodinator: BaseCoordinator) {
        removeDependency(coodinator)
        videoPlayerCoordinator = nil
        textDetailCoordinator = nil
        playerCoordinator = nil
    }
}
