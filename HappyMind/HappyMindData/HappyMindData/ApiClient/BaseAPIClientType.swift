//
//  BaseAPIClientType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

import Combine
import Alamofire
public protocol BaseAPIClientType: AnyObject {
    func request<Response:Codable>(_ endpoint: Endpoint) -> AnyPublisher<Response, DifferentError>
}
