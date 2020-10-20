//
//  ApplicationPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import HappyMindCore

final class ApplicationPresenter: BasePresenter {

    var ownView: ApplicationView! {
        view as? ApplicationView
    }

    struct InputDependencies {
        weak var coordinator: ApplicationCoordinatorDelegate?
        let firstTimeInteractor: FirstTimeInteractor
    }

    private let inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewDidLoad() {
        getIfIsFirtsTimeOnApplication()
    }

    private func getIfIsFirtsTimeOnApplication() {
        inputDependencies.firstTimeInteractor.execute(nil).sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case.failure(let error):
                self?.inputDependencies.coordinator?.showLogin()
            case.finished:
                break
            }
        }) { [weak self] (bool) in
            self?.inputDependencies.coordinator?.showCategories()
        }.store(in: &subscriptions)
    }
}

extension ApplicationPresenter: ApplicationPresenterType {

}
