//
//  ThemeRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class ThemeRepository: ThemeRepositoryType {
    
    private let service: BaseService

    public init(service: BaseService) {
        self.service = service
    }
    
    public func getThemes(idSubCategory: String) -> AnyPublisher<ThemesDto, Error> {
        let path = "category/\(idSubCategory)/themes"
        let endpoint = Endpoint(method: .get, relativePath: path)
        return service.apiClient.request(endpoint)
    }
}
