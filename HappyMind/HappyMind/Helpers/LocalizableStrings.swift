//
//  LocalizableStrings.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

extension String {
    enum Localized: String {
        case happyMindTitle = "happymind"
        case email = "email"
        case password = "password"
        case login = "login"
    }


    static func localized(_ key: Localized) -> String {
        return NSLocalizedString(key.rawValue, comment: "")
    }
}


