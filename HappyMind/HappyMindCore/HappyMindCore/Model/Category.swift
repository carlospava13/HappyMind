//
//  Category.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 14/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public enum CategoryType: Int {
    case subcategory = 1
    case other
}

public struct Category {
    public let id: String
    public let ref: String
    public let name: String
    public let type: CategoryType
    public let imagePath: CategoryFilePath
}

public struct CategoryFilePath: Codable {
    public let mediaPath: String
    public let mediaType: String
}
