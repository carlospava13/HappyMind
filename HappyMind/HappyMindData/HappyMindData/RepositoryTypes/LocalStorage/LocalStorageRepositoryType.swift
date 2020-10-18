//
//  LocalStorageRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public protocol LocalStorageRepositoryType {
    func saveData(value: Any, key: LocalStorageKey)
    func getData<T>(key: LocalStorageKey) throws -> T
    func remove(key: LocalStorageKey)
}
