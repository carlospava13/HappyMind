//
//  Category.swift
//  HappyMindData
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct CategoriesDTO: Codable {
    public let categories: [Category]
}

public struct Category: Codable {
    public let ref: String
    public let name: String
    public let type: Int
    public let imagePath: FilePath
}

public struct FilePath: Codable {
    public let mediaPath: String
    public let mediaType: String
}
