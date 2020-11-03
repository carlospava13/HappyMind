//
//  AudioPlayerPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import Combine
import HappyMindCore

final class AudioPlayerPresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: AudioPlayerCoodinatorDelegate?
        let mediaFileInteractor: MediaFileInteractor
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
        getMediaFile()
    }

    deinit {
        inputDependencies.coordinator?.removeReference()
    }
    
    private func getMediaFile() {
        inputDependencies.mediaFileInteractor.execute(nil).sink { (completion) in
            switch completion {
            case .failure(let error):
                self.ownView.show(error)
            case .finished: break
            }
        } receiveValue: { (mediafile) in
            self.ownView.set(urlSong: mediafile.urlFile + self.inputDependencies.theme.mediaFile.mediaPath,
                             token: mediafile.token)
            self.ownView.set(imageUrl: mediafile.urlImage +
                                self.inputDependencies.theme.coverImage.mediaPath!)
        }.store(in: &subscriptions)
    }
}

extension AudioPlayerPresenter: AudioPlayerPresenterType {

}
