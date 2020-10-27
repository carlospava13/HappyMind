//
//  ThemeDto.swift
//  HappyMindData
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct ThemesDto: Codable {
    public let themes: [ThemeDto]
}

public struct ThemeDto: Codable {
    public let id: String
    public let ref: String
    public let author: String
    public let title: String
    public let type: String
    public let coverImage: CoverImageDto
    public let mediaFile: MediaFileDto
    public let parentID: String
}

public struct CoverImageDto: Codable {
    public let mediaPath: String?
    public let mediaType: String
}
