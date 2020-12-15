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

    public func login(username: String) -> AnyPublisher<User, Error> {
        let endpoint = Endpoint(method: .post,
                                relativePath: "account/login",
                                header: ["device-key": "8896f338-5783-425a-80ac-7b6ca09823c7"],
                                parameters: ["email": username])
        return service.apiClient.request(endpoint)
    }
}
