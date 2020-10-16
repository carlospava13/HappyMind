//
//  CategoryPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
import HappyMindData
final class CategoryPresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: CategoryCoordinatorDelegate?
        var getCategoriesInteractor: GetCategoriesInteractor
    }

    private var inputDependencies: InputDependencies

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    private var ownView: CategoryView! {
        view as? CategoryView
    }

    override func viewDidLoad() {
        getCategories()
    }

    private func getCategories() {
         inputDependencies.getCategoriesInteractor.execute().sink(receiveCompletion: { (completion) in
            print(completion)
        }) { (categories) in
            let section = [Section<HappyMindCore.Category>(data: categories)]
            self.ownView.setData(section)
        }.store(in: &subscriptions)
    }
}

extension CategoryPresenter: CategoryPresenterType {

}
