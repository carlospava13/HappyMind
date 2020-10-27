//
//  Category.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct CategoriesDTO: Codable {
    public let categories: [CategoryDTO]
}

public struct CategoryDTO: Codable {
    public let id: String
    public let ref: String
    public let name: String
    public let type: String
    public let mediaFile: MediaFileDto
}

public struct MediaFileDto: Codable {
    public let mediaPath: String?
    public let mediaType: String?
}
