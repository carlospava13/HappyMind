//
//  ApiError.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import Alamofire

public enum DifferentError: Error {
    case alamofire(wrapped: AFError)
    case malformedURL
}
