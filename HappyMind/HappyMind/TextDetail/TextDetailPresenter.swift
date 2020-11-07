//
//  TextDetailPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

final class TextDetailPresenter: BasePresenter {
    struct InputDependencies {
        weak var coordinator: TextDetailCoordinatorDelegate?
        let theme: Theme
    }

    private var ownView: TextDetailView! {
        view as? TextDetailView
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }
    
    override func viewDidLoad() {
        showElementViews()
    }
    
    func showElementViews() {
        ownView.set(title: inputDependencies.theme.title)
        ownView.set(image: inputDependencies.theme.coverImage.mediaPath)
        ownView.set(textContent: inputDependencies.theme.textContent ?? "")
    }

}

extension TextDetailPresenter: TextDetailPresenterType {

}
