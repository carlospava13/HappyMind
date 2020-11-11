//
//  IsLoginInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 10/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class IsLoginInteractor: BaseInteractor<Any?, Bool> {
    private let localStorageRepository: LocalStorageRepositoryType

    public init(repository: LocalStorageRepositoryType) {
        localStorageRepository = repository
    }
    
    public override func execute(_ params: Any?) -> AnyPublisher<Bool, Error> {
        localStorageRepository.getData(key: .token).map { (token) -> String in
           return token
        }.map({ (token) -> Bool in
            return token.isEmpty
        }).eraseToAnyPublisher()
    }
}
