//
//  ApplicationPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import HappyMindCore
import Firebase

final class ApplicationPresenter: BasePresenter {

    private var ownView: ApplicationView! {
        view as? ApplicationView
    }

    struct InputDependencies {
        weak var coordinator: ApplicationCoordinatorDelegate?
        let registerDeviceInteractor: RegisterDeviceInteractor
        let firstTimeInteractor: FirstTimeInteractor
        let isLoginInteractor: IsLoginInteractor
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
            case.failure:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.inputDependencies.coordinator?.showLogin()
                    self?.registerDevice()
                }
            case.finished:
                break
            }
        }) { [weak self] (bool) in
            self?.isLogin()
        }.store(in: &subscriptions)
    }

    private func registerDevice() {
        guard let token = Messaging.messaging().apnsToken?.hexString else {
            return
        }

        inputDependencies.registerDeviceInteractor.execute(token).sink(receiveCompletion: { _ in
        }) { (bool) in
            print(bool)
        }.store(in: &subscriptions)
    }

    private func isLogin() {
        inputDependencies.isLoginInteractor.execute(nil).sink { [weak self] (completion) in
            switch completion {
            case.failure:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.inputDependencies.coordinator?.showLogin()
                }
            case.finished:
                break
            }
        } receiveValue: { [weak self] (value) in
            if (value) {
                self?.inputDependencies.coordinator?.showLogin()
            } else {
                self?.inputDependencies.coordinator?.showCategories()
            }
        }.store(in: &subscriptions)
    }
}

extension ApplicationPresenter: ApplicationPresenterType {

}
