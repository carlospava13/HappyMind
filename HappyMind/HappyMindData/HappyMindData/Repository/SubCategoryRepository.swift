//
//  SubCategoryRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class SubCategoryRepository: SubCategoryRepositoryType {

    private let service: BaseService

    public init(service: BaseService) {
        self.service = service
    }
    
    public func getSubCategories(idCategory: String) -> AnyPublisher<SubCategoriesDTO, Error> {
        let path = "category/\(idCategory)/subcategories"
        let endpoint = Endpoint(method: .get, relativePath: path)
        return service.apiClient.request(endpoint)
    }
}
