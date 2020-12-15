//
//  RegisterDeviceRepository.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/12/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public final class RegisterDeviceRepository: RegisterDeviceRepositoryType {
    
    private let service: BaseService

    public init(service: BaseService) {
        self.service = service
    }
    
    public func register(token: String) -> AnyPublisher<DeviceDto, Error> {
        let path = "devices"
        let endpoint = Endpoint(method: .post,
                                relativePath: path,
                                parameters: ["deviceId": token, "platform": "ios"])
        return service.apiClient.request(endpoint)
    }
}
