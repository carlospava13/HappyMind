//
//  Theme.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public enum FileType: String {
    case video
    case audio
    case text
}

public struct Theme{
    public let id: String
    public let ref: String
    public let author: String
    public let title: String
    public let type: FileType
    public let coverImage: CoverImage
    public let mediaFile: ThemeFilePath
    public let parentID: String
    public let textContent: String?
    public let isChecked: Bool?
}

public struct ThemeFilePath: Codable {
    public let mediaPath: String
    public let mediaType: String
}

public struct CoverImage: Codable {
    public let mediaPath: String?
    public let mediaType: String
}
