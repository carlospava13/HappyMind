//
//  CheckThemeRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 10/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class CheckThemeRepository: CheckThemeRepositoryType {
  
    private let service: BaseService

    public init(service: BaseService) {
        self.service = service
    }
    
    public func checkTheme(ref: String, token: String) -> AnyPublisher<CheckThemeDto, Error> {
        let path = "theme/\(ref)/check"
        let endpoint = Endpoint(method: .post, relativePath: path,
                                header: ["Authorization": "Bearer \(token)"])
        return service.apiClient.request(endpoint)
    }
}
