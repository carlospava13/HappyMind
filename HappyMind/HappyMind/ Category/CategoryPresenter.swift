//
//  CategoryPresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class CategoryPresenter: BasePresenter {
    
    struct InputDependencies {
        weak var coordinator: CategoryCoordinatorDelegate?
    }
    
    private var inputDependencies: InputDependencies
    
    init(inputDependencies: InputDependencies) {
        self.inputDependencies = inputDependencies
    }

    private var ownView: CategoryView! {
        view as? CategoryView
    }

    override func viewDidLoad() {
        populateData()
    }

    func populateData() {

        let subcategories1 = [
            SubCategoryModel(name: "Categoria1", image: UIImage(named: "category1")!),
            SubCategoryModel(name: "Categoria2", image: UIImage(named: "category2")!),
            SubCategoryModel(name: "Categoria3", image: UIImage(named: "category1")!),
            SubCategoryModel(name: "Categoria4", image: UIImage(named: "category2")!),
            SubCategoryModel(name: "Categoria4", image: UIImage(named: "category2")!),
            SubCategoryModel(name: "Categoria4", image: UIImage(named: "category2")!),
            SubCategoryModel(name: "Categoria4", image: UIImage(named: "category2")!),

        ]
        let section1 = Section<SubCategoryModel>(data: subcategories1)

        let category1 = Section<CategoryModel>(data: [CategoryModel(title: "Nombre de la categoria", subcategories: section1)])


        let subcategories2 = [
            SubCategoryModel(name: "Categoria1", image: UIImage(named: "category1")!),
            SubCategoryModel(name: "Categoria2", image: UIImage(named: "category2")!),
        ]
        let section2 = Section<SubCategoryModel>(data: subcategories2)

        let category2 = Section<CategoryModel>(data: [CategoryModel(title: "Nombre de la categoria Dos", subcategories: section2)])

        let subcategories3 = [
            SubCategoryModel(name: "Categoria1", image: UIImage(named: "category1")!),
            SubCategoryModel(name: "Categoria2", image: UIImage(named: "category2")!),
            SubCategoryModel(name: "Categoria1", image: UIImage(named: "category1")!),
            SubCategoryModel(name: "Categoria2", image: UIImage(named: "category2")!),
        ]
        let section3 = Section<SubCategoryModel>(data: subcategories3)

        let category3 = Section<CategoryModel>(data: [CategoryModel(title: "Nombre de la categoria Tres", subcategories: section3)])

        ownView.setData([category1, category2,category3])
    }
}

extension CategoryPresenter: CategoryPresenterType {

}
