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

    public init(repository: SubCategoryRepositoryType) {
        self.repository = repository
    }

    public override func execute(_ params: String) -> AnyPublisher<[SubCategory], Error> {
        return repository.getSubCategories(idCategory: params).map { (subcategories) -> [SubCategory] in
            return subcategories.subcategories.map { (subcategory) -> SubCategory in
                SubCategory(id: subcategory.id,
                    ref: subcategory.ref,
                    name: subcategory.name,
                    mediaFile: SubCategoryFilePath(mediaPath: subcategory.mediaFile.mediaPath ?? "",
                        mediaType: subcategory.mediaFile.mediaType ?? ""))
            }
        }.eraseToAnyPublisher()
    }
}
