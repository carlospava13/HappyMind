//
//  AudioPlayerConfigurator.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class AudioPlayerConfigurator {

    static func configure(moduleInput: AudioPlayerConfigurator.ModuleInput) -> UIViewController {

        let applicationViewController = AudioPlayerViewController()
        let dependencies = createDependencies(
            coordinator: moduleInput.coordinator,
            theme: moduleInput.theme)
        let presenter = AudioPlayerPresenter(inputDependencies: dependencies)
        applicationViewController.presenter = presenter
        return applicationViewController
    }

    private static func createDependencies(coordinator: AudioPlayerCoodinatorDelegate?,
                                           theme: Theme) -> AudioPlayerPresenter.InputDependencies {
        return AudioPlayerPresenter.InputDependencies(coordinator: coordinator,
                                                      theme: theme)
    }

    static func module(moduleInput: AudioPlayerConfigurator.ModuleInput) -> (UIViewController) {
        return configure(moduleInput: moduleInput)
    }
}
extension AudioPlayerConfigurator {
    struct ModuleInput {
        weak var coordinator: AudioPlayerCoodinatorDelegate?
        let theme: Theme
    }
}
