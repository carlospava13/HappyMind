//
//  Configuration.swift
//  HappyMindData
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import class Foundation.Bundle

public enum Configuration {
  enum Error: Swift.Error {
    case missingKey, invalidValue
  }
  
  public static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
      throw Error.missingKey
    }
    
    switch object {
    case let value as T:
      return value
    case let string as String:
      guard let value = T(string) else { throw Error.invalidValue }
      return value
    default:
      throw Error.invalidValue
    }
  }
  
  public static var baseURL: String {
    return try! value(for: "baseUrl")
  }
}
