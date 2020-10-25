//
//  SubCategory.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public struct SubCategory {
    public let id: String
    public let ref: String
    public let name: String
    public let mediaFile: SubCategoryFilePath
}

public struct SubCategoryFilePath: Codable {
    public let mediaPath: String
    public let mediaType: String
}
