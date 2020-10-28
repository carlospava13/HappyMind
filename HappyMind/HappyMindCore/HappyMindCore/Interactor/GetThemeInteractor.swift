//
//  GetThemeInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class GetThemeInteractor: BaseInteractor<String, [Theme]> {

    private let repository: ThemeRepositoryType

    public init(repository: ThemeRepositoryType) {
        self.repository = repository
    }

    public override func execute(_ params: String) -> AnyPublisher<[Theme], Error> {
        return repository.getThemes(idSubCategory: params).map { (themesDto) -> [Theme] in
            return themesDto.themes.map { (themeDto) -> Theme in
                return Theme(id: themeDto.id,
                             ref: themeDto.ref,
                             author: themeDto.author,
                             title: themeDto.title,
                             type: FileType(rawValue: themeDto.type)!,
                             coverImage: CoverImage(mediaPath: themeDto.coverImage.mediaPath,
                                                    mediaType: themeDto.coverImage.mediaType),
                             mediaFile: ThemeFilePath(mediaPath: themeDto.mediaFile.mediaPath ?? "",
                                                      mediaType: themeDto.mediaFile.mediaType ?? ""),
                             parentID: themeDto.parentID)
            }
        }.eraseToAnyPublisher()
    }
}
