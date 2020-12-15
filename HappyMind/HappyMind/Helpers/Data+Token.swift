//
//  Data+Token.swift
//  HappyMind
//
//  Created by Carlos Pava on 14/12/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
