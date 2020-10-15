//
//  Endpoint.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Alamofire

public class Endpoint {
    public let method: HTTPMethod
    public let relativePath: String
    public let parameters: [String: Any]?
    public let parameterEncoding: ParameterEncoding

    public init(method: HTTPMethod = .get,
        relativePath: String,
        parameters: [String: Any]? = nil,
        parameterEncoding: ParameterEncoding = URLEncoding.default) {
        self.method = method
        self.relativePath = relativePath
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
    }
}
