//
//  TextDetailPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

final class TextDetailPresenter: BasePresenter {
    struct InputDependencies {
        weak var coordinator: TextDetailCoordinatorDelegate?
    }

    private var ownView: CategoryView! {
        view as? CategoryView
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

}

extension TextDetailPresenter: TextDetailPresenterType {

}
