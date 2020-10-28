//
//  WelcomePresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

final class WelcomePresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: WelcomeCoordinatorDelegate?
        let setFirstTimeInteractor: SetFirstTimeInteractor
        let welcomeInteractor: WelcomeInteractor
    }

    private let inputDependencies: InputDependencies

    private var ownView: WelcomeView! {
        view as? WelcomeView
    }

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewDidLoad() {
        //setFirtTimeInteractor()
        getWelcomeInfo()
    }

    private func setFirtTimeInteractor() {
        inputDependencies.setFirstTimeInteractor.execute(nil).sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.ownView.show(error)
            case .finished:
                break
            }
        }, receiveValue: { _ in }).store(in: &subscriptions)
    }

    private func getWelcomeInfo() {
        ownView.showSkeleton()
        inputDependencies.welcomeInteractor.execute(nil).sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.ownView.show(error)
            case .finished:
                self?.ownView.hideSkeleton()
            }
        }, receiveValue: { [weak self] (welcome) in
            let section = [Section<Theme>(data: welcome.welcomeThemes, title: welcome.welcomeMessage)]
            self?.ownView.setData(section)
        }).store(in: &subscriptions)
    }


}

extension WelcomePresenter: WelcomePresenterType {
    func didSelected() {

    }

    func skip() {
        inputDependencies.coordinator?.dismiss()
    }

    func showVideo() {
        inputDependencies.coordinator?.showVideo()
    }
}
