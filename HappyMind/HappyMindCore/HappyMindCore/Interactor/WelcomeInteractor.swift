//
//  WelcomeInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 28/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class WelcomeInteractor: BaseInteractor<Any, Welcome> {

    private let repository: WelcomeRepositoryType

    public init(repository: WelcomeRepositoryType) {
        self.repository = repository
    }

    public override func execute(_ params: Any?) -> AnyPublisher<Welcome, Error> {
        return repository.getThemes().map { (welcomeDto) -> Welcome in
            return Welcome(welcomeMessage: welcomeDto.welcomeMessage, welcomeThemes: welcomeDto.welcomeThemes.map({ (themeDto) -> Theme in
                Theme(id: themeDto.id,
                    ref: themeDto.ref,
                    author: themeDto.author,
                    title: themeDto.title,
                    type: FileType(rawValue: themeDto.type)!,
                    coverImage: CoverImage(mediaPath: themeDto.coverImage.mediaPath,
                        mediaType: themeDto.coverImage.mediaType),
                    mediaFile: ThemeFilePath(mediaPath: themeDto.mediaFile.mediaPath ?? "",
                        mediaType: themeDto.mediaFile.mediaType ?? ""),
                    parentID: themeDto.parentID)
            }))
        }.eraseToAnyPublisher()
    }
}
