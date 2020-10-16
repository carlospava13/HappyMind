//
//  LoginInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class LoginInteractor: BaseInteractor<LoginParams, User> {
    
    private let repository: LoginRepositoryType
    
    public init(repository: LoginRepositoryType) {
        self.repository = repository
    }
    
    public override func execute(_ params: LoginParams) -> AnyPublisher<User, DifferentError> {
        return repository.login(username: params.email, password: params.password).map { (user) -> User in
            return User(token: user.token)
        }.eraseToAnyPublisher()
    }
}
