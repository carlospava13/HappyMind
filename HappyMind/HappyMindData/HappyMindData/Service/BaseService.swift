//
//  BaseService.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public final class BaseService {
    var apiClient: BaseAPIClientType
    
    public init(apiClient: BaseAPIClientType = BaseAPIClient()) {
        self.apiClient = apiClient
    }
}
