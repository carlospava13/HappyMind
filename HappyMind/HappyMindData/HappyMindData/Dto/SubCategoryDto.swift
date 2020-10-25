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
    public let mediaFile: MediaFileDTO
}

//"id": "5f94d5ccae0d5c9cd6cb1ab0",
//       "ref": "/subcategory/5f94d5ccae0d5c9cd6cb1ab0",
//       "name": "updated Category testing api 2",
//       "categoryID": "5f94d57cae0d5c9cd6cb1aaf",
//       "mediaFile": {
//           "mediaPath": "subcategories/5f94d5ccae0d5c9cd6cb1ab0.jpg",
//           "mediaType": "image"
//       }
