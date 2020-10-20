//
//  FirstTimeInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class FirstTimeInteractor: BaseInteractor<Any?, Bool> {
    private let localStorageRepository: LocalStorageRepositoryType

    public init(repository: LocalStorageRepositoryType) {
        localStorageRepository = repository
    }

    public override func execute(_ params: Any?) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promisse in
            do {
                let isFirstTime: Bool = try self.localStorageRepository.getData(key: .firstTime)
                promisse(.success(isFirstTime))
            } catch (let error) {
                promisse(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
