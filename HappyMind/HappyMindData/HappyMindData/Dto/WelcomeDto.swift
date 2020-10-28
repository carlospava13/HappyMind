//
//  WelcomeDto.swift
//  HappyMindData
//
//  Created by Carlos Pava on 28/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct WelcomeDto: Codable {
    public let welcomeMessage: String
    public let welcomeThemes: [ThemeDto]
}
