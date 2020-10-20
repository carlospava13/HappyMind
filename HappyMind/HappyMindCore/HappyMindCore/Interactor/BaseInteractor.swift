//
//  BaseInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public class BaseInteractor<Params, Response> {
    func execute(_ params: Params) -> AnyPublisher<Response, Error> {
        Future<Response, Error> { _ in }.eraseToAnyPublisher()
    }
}
