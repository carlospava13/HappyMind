//
//  AudioPlayerPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class AudioPlayerPresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: AudioPlayerCoodinatorDelegate?
        let theme: Theme
    }

    private let inputDependencies: InputDependencies
    
    private var ownView: AudioPlayerView! {
        view as? AudioPlayerView
    }

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }
    
    override func viewDidLoad() {
        ownView.set(author: inputDependencies.theme.author)
        ownView.set(songTitle: inputDependencies.theme.title)
        ownView.set(urlSong: "http://3.21.122.111/api/v1/mediafile?mediaPath=" + inputDependencies.theme.mediaFile.mediaPath)
    }

    deinit {
        inputDependencies.coordinator?.removeReference()
    }
}

extension AudioPlayerPresenter: AudioPlayerPresenterType {

}
