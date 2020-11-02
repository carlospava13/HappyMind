//
//  GetSubCatogoryInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class GetSubCatogoryInteractor: BaseInteractor<String, [SubCategory]> {

    private let repository: SubCategoryRepositoryType
    private let localStorageRepository: LocalStorageRepositoryType
    public init(repository: SubCategoryRepositoryType,
                localStorageRepository: LocalStorageRepositoryType) {
        self.repository = repository
        self.localStorageRepository = localStorageRepository
    }

    public override func execute(_ params: String) -> AnyPublisher<[SubCategory], Error> {
        let tokenPublisher = self.localStorageRepository.getData(key: .token).tryMap { (token) -> String in
            return token
        }
        return tokenPublisher.flatMap { (token) -> AnyPublisher<[SubCategory], Error> in
            return self.repository.getSubCategories(token: token,idCategory: params).map { (subcategories) -> [SubCategory] in
                return subcategories.subcategories.map { (subcategory) -> SubCategory in
                    SubCategory(id: subcategory.id,
                        ref: subcategory.ref,
                        name: subcategory.name,
                        mediaFile: SubCategoryFilePath(mediaPath: subcategory.mediaFile.mediaPath ?? "",
                            mediaType: subcategory.mediaFile.mediaType ?? ""))
                }
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
