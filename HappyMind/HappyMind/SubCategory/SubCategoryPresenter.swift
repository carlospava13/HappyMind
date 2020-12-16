//
//  SubCategoryPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

final class SubCategoryPresenter: BasePresenter {

    struct InputDependencies {
        weak var coordinator: SubCategoryCoordinatorDelegate?
        let getSubCatogoryInteractor: GetSubCatogoryInteractor
        let category: HappyMindCore.Category
    }

    let inputDependencies: InputDependencies

    private var ownView: SubCategoryView! {
        view as? SubCategoryView
    }

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    deinit {
        inputDependencies.coordinator?.removeReference()
    }

    override func viewDidLoad() {
        ownView.set(title: inputDependencies.category.name)
    }

    override func viewWillAppear() {
        getSubcategories(idCategory: inputDependencies.category.id)
    }

    func getSubcategories(idCategory: String) {
        inputDependencies.getSubCatogoryInteractor.execute(idCategory).sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .failure(let error):
                self?.ownView.show(error.localizedDescription)
            case .finished:
                break
            }
        }) { [weak self] (subcategories) in
            let section = [Section<SubCategory>(data: subcategories)]
            self?.ownView.setData(section)
        }.store(in: &subscriptions)
    }
}

extension SubCategoryPresenter: SubCategoryPresenterType {
    func didSelected(subcategory: SubCategory) {
        inputDependencies.coordinator?.showTheme(subcategory: subcategory)
    }
}
