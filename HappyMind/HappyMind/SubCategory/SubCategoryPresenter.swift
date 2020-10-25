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
        let categoryId: String
    }

    let inputDependencies: InputDependencies

    private var ownView: SubCategoryView! {
        view as? SubCategoryView
    }

    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    override func viewDidLoad() {
        getSubcategories(idCategory: inputDependencies.categoryId)
    }

    func getSubcategories(idCategory: String) {
        ownView.showSkeleton()
        inputDependencies.getSubCatogoryInteractor.execute(idCategory).sink(receiveCompletion: { (completion) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                self.ownView.hideSkeleton()
            }

        }) { (subcategories) in
            let section = [Section<SubCategory>(data: subcategories)]
            self.ownView.setData(section)
        }.store(in: &subscriptions)
    }
}

extension SubCategoryPresenter: SubCategoryPresenterType {

}
