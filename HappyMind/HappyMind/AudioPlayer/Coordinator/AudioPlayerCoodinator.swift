//
//  AudioPlayerCoodinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol AudioPlayerCoodinatorDelegate: AnyObject {
    func removeReference()
}

final class AudioPlayerCoodinator: BaseCoordinator {
    private let interactorModule: InteractorModule

    init(router: RouterType,
        interactorModule: InteractorModule) {
        self.interactorModule = interactorModule
        super.init(router: router)
    }

    override func start() {
        let moduleInput = AudioPlayerConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule)
        let module = AudioPlayerConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }
}

extension AudioPlayerCoodinator: AudioPlayerCoodinatorDelegate {
    func removeReference() {
        removeReferenceDelegete?.removeReference(self)
    }
}
