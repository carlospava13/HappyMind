//
//  GetCategoriesInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData
public final class GetCategoriesInteractor: BaseInteractor<Any, [Category]> {

    private let repository: CategoryRepositoryType

    public init(repository: CategoryRepositoryType) {
        self.repository = repository
    }

    public override func execute(_ params: Any? = nil) -> AnyPublisher<[Category], DifferentError> {
        return repository.getCategories().map { (categories) -> [Category] in
            return categories.categories.map { (category) -> Category in
                return Category(ref: category.ref,
                    name: category.name,
                    type: CategoryType(rawValue: category.type)!,
                    imagePath: CategoryFilePath(mediaPath: category.imagePath.mediaPath,
                        mediaType: category.imagePath.mediaType))
            }
        }.eraseToAnyPublisher()
    }
}
