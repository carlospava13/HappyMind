//
//  AudioPlayerConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class AudioPlayerConfigurator {

    static func configure(moduleInput: AudioPlayerConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = AudioPlayerViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator, interactorModule: moduleInput.interactorModule)
        let presenter = AudioPlayerPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: AudioPlayerCoodinatorDelegate?, interactorModule: InteractorModule) -> AudioPlayerPresenter.InputDependencies {
        return AudioPlayerPresenter.InputDependencies(coordinator: coordinator)
    }

    static func module(moduleInput: AudioPlayerConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension AudioPlayerConfigurator {
    struct ModuleInput {
        weak var coordinator: AudioPlayerCoodinatorDelegate?
        let interactorModule: InteractorModule
    }
}
