//
//  LogOutInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 9/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class LogOutInteractor: BaseInteractor<Any?, Void> {
    private let localStorageRepository: LocalStorageRepositoryType

    public init(repository: LocalStorageRepositoryType) {
        localStorageRepository = repository
    }
    
    public override func execute(_ params: Any?) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.localStorageRepository.remove(key: .token)
            promise(.success(()))
        }.eraseToAnyPublisher()
    }
}
