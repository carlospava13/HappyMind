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
    private let localStorageRepository: LocalStorageRepositoryType
    
    public init(repository: WelcomeRepositoryType,
        localStorageRepository: LocalStorageRepositoryType) {
        self.repository = repository
        self.localStorageRepository = localStorageRepository
    }

    public override func execute(_ params: Any?) -> AnyPublisher<Welcome, Error> {
        
        let tokenPublisher = self.localStorageRepository.getData(key: .token).tryMap { (token) -> String in
            return token
        }
        return tokenPublisher.flatMap { (token) -> AnyPublisher<Welcome, Error> in
            return self.repository.getThemes(token: token).map { (welcomeDto) -> Welcome in
                return Welcome(welcomeMessage: welcomeDto.welcomeMessage,
                               welcomeThemes: welcomeDto.welcomeThemes.map({ (themeDto) -> Theme in
                    Theme(id: themeDto.id,
                        ref: themeDto.ref,
                        author: themeDto.author,
                        title: themeDto.title,
                        type: FileType(rawValue: themeDto.type)!,
                        coverImage: CoverImage(mediaPath: themeDto.coverImage.mediaPath,
                            mediaType: themeDto.coverImage.mediaType),
                        mediaFile: ThemeFilePath(mediaPath: themeDto.mediaFile?.mediaPath ?? "",
                            mediaType: themeDto.mediaFile?.mediaType ?? ""),
                        parentID: themeDto.parentID,
                        textContent: themeDto.textContent,
                        isChecked: themeDto.isChecked)
                }))
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
