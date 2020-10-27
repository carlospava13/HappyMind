//
//  AudioPlayerCoodinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

protocol AudioPlayerCoodinatorDelegate: AnyObject {
    func removeReference()
}

final class AudioPlayerCoodinator: BaseCoordinator {
    private let interactorModule: InteractorModule
    private let theme: Theme
    
    init(router: RouterType,
        interactorModule: InteractorModule,
        theme: Theme) {
        self.interactorModule = interactorModule
        self.theme = theme
        super.init(router: router)
    }

    override func start() {
        let moduleInput = AudioPlayerConfigurator.ModuleInput(coordinator: self, interactorModule: interactorModule,
            theme: theme)
        let module = AudioPlayerConfigurator.module(moduleInput: moduleInput)
        router.present(module)
    }
}

extension AudioPlayerCoodinator: AudioPlayerCoodinatorDelegate {
    func removeReference() {
        removeReferenceDelegete?.removeReference(self)
    }
}
