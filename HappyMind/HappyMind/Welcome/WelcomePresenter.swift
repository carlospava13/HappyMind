//
//  WelcomePresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

final class WelcomePresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: WelcomeCoordinatorDelegate?
    }

    private let inputDependencies: InputDependencies

    private var ownView: WelcomeView! {
        view as? WelcomeView
    }

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewDidLoad() {
        populateData()
    }

    func populateData() {
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
        ownView.setData([Section<WelcomeObject>(data: data, title: nil)])
    }
}

extension WelcomePresenter: WelcomePresenterType {

}
