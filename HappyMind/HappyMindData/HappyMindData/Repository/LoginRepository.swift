//
//  LoginRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class LoginRepository: LoginRepositoryType {
    
    private let service: BaseService
    
    public init(service: BaseService) {
        self.service = service
    }
    
    public func login(username: String, password: String) -> AnyPublisher<User, DifferentError> {
        let endpoint = Endpoint(method: .post, relativePath: "account/login", parameters: ["email": username, "password": password])
        return service.apiClient.request(endpoint)
    }
}
