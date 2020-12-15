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
    private let localStorageRepository: LocalStorageRepositoryType
    
    public init(repository: LoginRepositoryType,
                localStorageRepository: LocalStorageRepositoryType) {
        self.repository = repository
        self.localStorageRepository = localStorageRepository
    }
    
    public override func execute(_ params: LoginParams) -> AnyPublisher<User, Error> {
        return repository.login(username: params.email).map { (user) -> User in
            self.localStorageRepository.saveData(value: user.token, key: .token)
            return User(token: user.token)
        }.eraseToAnyPublisher()
    }
}
