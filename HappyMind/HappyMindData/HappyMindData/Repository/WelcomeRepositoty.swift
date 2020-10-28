//
//  WelcomeRepositoty.swift
//  HappyMindData
//
//  Created by Carlos Pava on 28/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class WelcomeRepositoty: WelcomeRepositoryType {
    
    private let service: BaseService

    public init(service: BaseService) {
        self.service = service
    }

    public func getThemes() -> AnyPublisher<WelcomeDto, Error> {
        let path = "welcome"
        let endpoint = Endpoint(method: .get, relativePath: path)
        return service.apiClient.request(endpoint)
    }
}
