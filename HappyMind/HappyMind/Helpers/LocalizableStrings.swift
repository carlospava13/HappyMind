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
        case email
        case password
        case login
        case welcome
        case skip
    }


    static func localized(_ key: Localized) -> String {
        return NSLocalizedString(key.rawValue, comment: "")
    }
}


