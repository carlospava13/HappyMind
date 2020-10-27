//
//  ThemeRepositoryType.swift
//  HappyMindData
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

public protocol ThemeRepositoryType {
    func getThemes(idSubCategory: String) -> AnyPublisher<ThemesDto, Error>
}
