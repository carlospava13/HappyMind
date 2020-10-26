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
        populateData()
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

    func populateData() {
        ownView.showSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.ownView.hideSkeleton()
            let data = [
                WelcomeObject(title: "Categoria1"),
                WelcomeObject(title: "Categoria2"),
                WelcomeObject(title: "Categoria3"),
                WelcomeObject(title: "Categoria4"),
                WelcomeObject(title: "Categoria5"),
                WelcomeObject(title: "Categoria6"),
                WelcomeObject(title: "Categoria7"),
                WelcomeObject(title: "Categoria8"),
                WelcomeObject(title: "Categoria9")]
            self.ownView.setData([Section<WelcomeObject>(data: data, title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries")])
        }
    }
}

extension WelcomePresenter: WelcomePresenterType {
    func didSelected() {
        inputDependencies.coordinator?.showPlayerViewController()
    }

    func skip() {
        inputDependencies.coordinator?.dismiss()
    }
    
    func showVideo() {
        inputDependencies.coordinator?.showVideo()
    }
}
