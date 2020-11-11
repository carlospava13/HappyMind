//
//  LocalStorageRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import Combine

public final class LocalStorageRepository: LocalStorageRepositoryType {

    private let defaults = UserDefaults.standard

    public init() { }

    public func saveData(value: Any, key: LocalStorageKey) {
        defaults.set(value, forKey: key.rawValue)
    }

    public func remove(key: LocalStorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }

    public func getData<T>(key: LocalStorageKey) -> AnyPublisher<T, Error> {
        Future<T, Error> ({ emitter in
            if let data = self.defaults.value(forKey: key.rawValue) as? T {
                emitter(.success(data))
            }
            emitter(.failure(LocalStorageError.notFound))
        }).eraseToAnyPublisher()
    }
}
