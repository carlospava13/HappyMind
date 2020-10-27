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
        let subCategory: HappyMindCore.SubCategory
    }

    private var ownView: ThemeView! {
        view as? ThemeView
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewDidLoad() {
        getThemes()
        ownView.set(title: inputDependencies.subCategory.name)
    }

    private func getThemes() {
        ownView.showSkeleton()
        inputDependencies.getThemeInteractor.execute(inputDependencies.subCategory.id).sink { (completion) in
            switch completion {
            case .failure(let error):
                self.ownView.show(error)
            case .finished:
                self.ownView.hideSkeleton()
            }
        } receiveValue: { (themes) in
            let section = [Section<HappyMindCore.Theme>(data: themes)]
            self.ownView.setData(section)
        }.store(in: &subscriptions)
    }

}

extension ThemePresenter: ThemePresenterType {
    func didSelected(theme: Theme) {
        inputDependencies.coordinator?.showAudioPlayer(theme: theme)
    }
}
