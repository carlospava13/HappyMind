//
//  CategoryPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class CategoryPresenter: BasePresenter {

    struct InputDependencies {
        let coordinator: CategoryCoordinatorDelegate?
        var getCategoriesInteractor: GetCategoriesInteractor
    }

    private var ownView: CategoryView! {
        view as? CategoryView
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewDidLoad() {
        getCategories()
    }

    private func getCategories() {
        ownView.showSkeleton()
        inputDependencies.getCategoriesInteractor.execute().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.ownView.show(error)
            case .finished:
                self?.ownView.hideSkeleton()
            }
        }) { [weak self](categories) in
            let section = [Section<HappyMindCore.Category>(data: categories)]
            self?.ownView.setData(section)
        }.store(in: &subscriptions)
    }
}

extension CategoryPresenter: CategoryPresenterType {
    func didSelect(_ item: HappyMindCore.Category) {
        switch item.type {
        case .subcategories:
            inputDependencies.coordinator?.showSubCategories(category: item)
        case .themes:
       
            inputDependencies.coordinator?.showTheme(category: item)
        case .other:
            break
        }
    }
    
    func goToWelcome() {
        inputDependencies.coordinator?.showWelcome()
    }
}
