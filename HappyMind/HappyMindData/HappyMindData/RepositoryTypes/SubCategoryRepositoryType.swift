//
//  SubCategoryRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public protocol SubCategoryRepositoryType {
    func getSubCategories(idCategory: String) -> AnyPublisher<SubCategoriesDTO, Error>
}
