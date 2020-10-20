//
//  SetFirstTimeInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class SetFirstTimeInteractor: BaseInteractor<Any?, Void> {
    private let localStorageRepository: LocalStorageRepositoryType

    public init(repository: LocalStorageRepositoryType) {
        localStorageRepository = repository
    }

    public override func execute(_ params: Any?) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promisse in
            self.localStorageRepository.saveData(value: true, key: .firstTime)
            promisse(.success(()))
        }.eraseToAnyPublisher()
    }
}
