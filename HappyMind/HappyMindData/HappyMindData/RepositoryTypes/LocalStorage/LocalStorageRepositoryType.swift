//
//  LocalStorageRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import Combine

public protocol LocalStorageRepositoryType {
    func saveData(value: Any, key: LocalStorageKey)
    func getData<T>(key: LocalStorageKey) -> AnyPublisher<T, Error>
    func remove(key: LocalStorageKey)
}
