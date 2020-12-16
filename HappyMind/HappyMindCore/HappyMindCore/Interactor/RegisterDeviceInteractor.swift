//
//  RegisterDeviceInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 14/12/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class RegisterDeviceInteractor: BaseInteractor<String, Void> {
    
    private let registerDeviceRepository: RegisterDeviceRepositoryType
    
    public init(repository: RegisterDeviceRepositoryType) {
        self.registerDeviceRepository = repository
    }
    
    public override func execute(_ params: String) -> AnyPublisher<Void, Error> {
        registerDeviceRepository.register(token: params).map({
            print("\n MESSAGE \($0.message) \n")
        }).eraseToAnyPublisher()
    }
}
