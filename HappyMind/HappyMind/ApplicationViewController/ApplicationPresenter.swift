//
//  ApplicationPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

final class ApplicationPresenter: BasePresenter {

    var ownView: ApplicationView! {
        view as? ApplicationView
    }

    struct InputDependencies {
        weak var coordinator: ApplicationCoordinatorDelegate?
    }

    private let inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }


}

extension ApplicationPresenter: ApplicationPresenterType {

}
