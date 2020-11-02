//
//  WelcomeRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 28/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public protocol WelcomeRepositoryType {
    func getThemes(token: String) -> AnyPublisher<WelcomeDto, Error>
}
