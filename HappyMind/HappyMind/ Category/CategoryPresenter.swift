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
        var logOutInteractor: LogOutInteractor
    }

    private var ownView: CategoryView! {
        view as? CategoryView
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewWillAppear() {
        getCategories()
    }

    private func getCategories() {
        inputDependencies.getCategoriesInteractor.execute().sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.ownView.show(error.localizedDescription)
                self?.inputDependencies.coordinator?.showLogin()
            case .finished:
                break
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
    
    func logOut() {
        inputDependencies.logOutInteractor.execute(nil).sink { (completion) in
            self.inputDependencies.coordinator?.showLogin()
        } receiveValue: { _ in }.store(in: &subscriptions)
    }
}
