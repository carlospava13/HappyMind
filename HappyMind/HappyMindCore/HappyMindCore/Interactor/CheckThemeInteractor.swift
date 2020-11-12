//
//  CheckThemeInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 10/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class CheckThemeInteractor: BaseInteractor<Theme, Void> {

    private let repository: CheckThemeRepositoryType
    private let localStorageRepository: LocalStorageRepositoryType
    
    public init(repository: CheckThemeRepositoryType,
        localStorageRepository: LocalStorageRepositoryType) {
        self.repository = repository
        self.localStorageRepository = localStorageRepository
    }

    public override func execute(_ params: Theme) -> AnyPublisher<Void, Error> {
        
        let tokenPublisher = self.localStorageRepository.getData(key: .token).tryMap { (token) -> String in
            return token
        }
        return tokenPublisher.flatMap { (token) -> AnyPublisher<Void, Error> in
            return self.repository.checkTheme(ref: params.id, token: token).map { (checked) -> Void in
                ()
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}

