//
//  CategoryPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class CategoryPresenter: BasePresenter {

    private var ownView: CategoryView! {
        view as? CategoryView
    }

    override func viewDidLoad() {
        populateData()
    }

    func populateData() {
        let categories = [
            CategoryModel(name: "Categoria1", image: UIImage(named: "category1")!),
            CategoryModel(name: "Categoria2", image: UIImage(named: "category2")!)
        ]
        ownView.setData(categories)
    }
}

extension CategoryPresenter: CategoryPresenterType {

}
