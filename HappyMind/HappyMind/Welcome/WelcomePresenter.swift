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
        ownView.showSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
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
            self.ownView.setData([Section<WelcomeObject>(data: data, title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")])
        }
    }
}

extension WelcomePresenter: WelcomePresenterType {

}
