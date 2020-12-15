//
//  RegisterDeviceRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/12/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public protocol RegisterDeviceRepositoryType {
    func register(token: String) -> AnyPublisher<DeviceDto, Error>
}
