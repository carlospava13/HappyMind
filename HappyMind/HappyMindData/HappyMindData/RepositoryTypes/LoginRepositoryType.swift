//
//  LoginRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public protocol LoginRepositoryType {
    func login(username: String) -> AnyPublisher<User, Error>
}
