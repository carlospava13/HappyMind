//
//  CheckThemeRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 10/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public protocol CheckThemeRepositoryType {
    func checkTheme(ref: String, token: String) -> AnyPublisher<CheckThemeDto, Error>
}
