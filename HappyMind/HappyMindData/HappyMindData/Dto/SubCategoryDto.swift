//
//  SubCategoryDto.swift
//  HappyMindData
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct SubCategoriesDTO: Codable {
    public let subcategories: [SubCategoryDTO]
}

public struct SubCategoryDTO: Codable {
    public let id: String
    public let ref: String
    public let name: String
    public let categoryID: String
    public let mediaFile: MediaFileDto
    public let isChecked: Bool
}
