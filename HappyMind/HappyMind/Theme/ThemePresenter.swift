//
//  ThemePresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindCore

final class ThemePresenter: BasePresenter {

    struct InputDependencies {
        let coordinator: ThemeCoordinatorDelegate?
        let getThemeInteractor: GetThemeInteractor
        let name: String
        let id: String
    }

    private var ownView: ThemeView! {
        view as? ThemeView
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }
    
    deinit {
        inputDependencies.coordinator?.removeReference()
    }

    override func viewDidLoad() {
        ownView.set(title: inputDependencies.name)
        
    }
    
    override func viewWillAppear() {
        getThemes()
    }

    private func getThemes() {
        ownView.showSkeleton()
        inputDependencies.getThemeInteractor.execute(inputDependencies.id).sink { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.ownView.show(error.localizedDescription)
            case .finished:
                self?.ownView.hideSkeleton()
            }
        } receiveValue: { [weak self] (themes) in
            let section = [Section<HappyMindCore.Theme>(data: themes)]
            self?.ownView.setData(section)
        }.store(in: &subscriptions)
    }

}

extension ThemePresenter: ThemePresenterType {
    func didSelected(theme: Theme) {
        switch theme.type {
        case .audio:
            inputDependencies.coordinator?.showAudioPlayer(theme: theme)
        case .video:
            inputDependencies.coordinator?.showVideoPlayer(theme: theme)
        case .text:
            inputDependencies.coordinator?.showTextDetail(theme: theme)
        }
    }
}
