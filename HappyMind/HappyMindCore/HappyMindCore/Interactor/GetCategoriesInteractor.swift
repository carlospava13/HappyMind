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
    private let localStorageRepository: LocalStorageRepositoryType

    public init(repository: CategoryRepositoryType,
                localStorageRepository: LocalStorageRepositoryType) {
        self.repository = repository
        self.localStorageRepository = localStorageRepository
    }

    public override func execute(_ params: Any? = nil) -> AnyPublisher<[Category], Error> {
        
        let tokenPublisher = self.localStorageRepository.getData(key: .token).tryMap { (token) -> String in
            return token
        }
        return tokenPublisher.flatMap { (token) -> AnyPublisher<[Category], Error> in
            return self.repository.getCategories(token: token).map { (categories) -> [Category] in
                return categories.categories.map { (category) -> Category in
                    return Category(
                        id: category.id,
                        ref: category.ref,
                        name: category.name,
                        type: CategoryType(rawValue: category.type)!,
                        imagePath: CategoryFilePath(mediaPath: category.mediaFile.mediaPath ?? "",
                                                    mediaType: category.mediaFile.mediaType ?? ""),
                        isChecked: category.isChecked)
                }
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
