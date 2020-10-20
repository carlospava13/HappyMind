//
//  CategoryRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//


import Combine

public protocol CategoryRepositoryType {
    func getCategories() -> AnyPublisher<CategoriesDTO, Error>
}
