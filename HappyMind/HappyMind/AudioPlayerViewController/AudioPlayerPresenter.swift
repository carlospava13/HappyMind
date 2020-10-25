//
//  AudioPlayerPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import AVFoundation
final class AudioPlayerPresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: AudioPlayerCoodinatorDelegate?
    }

    private let inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    deinit {
        inputDependencies.coordinator?.removeReference()
    }
}

extension AudioPlayerPresenter: AudioPlayerPresenterType {

}
