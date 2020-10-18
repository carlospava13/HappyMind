//
//  LocalStorageRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public final class LocalStorageRepository: LocalStorageRepositoryType {

    private let defaults = UserDefaults.standard

    public init() { }

    public func saveData(value: Any, key: LocalStorageKey) {
        defaults.setValue(value, forKey: key.rawValue)
    }

    public func remove(key: LocalStorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    public func getData<T>(key: LocalStorageKey) throws -> T {
        guard let data = defaults.value(forKey: key.rawValue) as? T else {
            throw LocalStorageError.notFound
        }
        return data
    }
}

public enum LocalStorageError: Error {
    case notFound
}
