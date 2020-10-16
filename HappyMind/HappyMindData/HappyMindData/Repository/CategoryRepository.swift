//
//  CategoryRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class CategoryRepository: CategoryRepositoryType {
    
    private let service: BaseService
    
    public init(service: BaseService) {
        self.service = service
    }
    
    public func getCategories() -> AnyPublisher<CategoriesDTO, DifferentError> {
        let endpoint = Endpoint(method: .get, relativePath: "category")
        return service.apiClient.request(endpoint)
    }
}
