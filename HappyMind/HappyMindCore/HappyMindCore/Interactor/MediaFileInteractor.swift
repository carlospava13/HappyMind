//
//  MediaFileInteractor.swift
//  HappyMindCore
//
//  Created by Carlos Pava on 2/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine
import HappyMindData

public final class MediaFileInteractor: BaseInteractor<Any?, MediaFile> {
    
    private let localStorageRepository: LocalStorageRepositoryType
    
    public init(localStorageRepository: LocalStorageRepositoryType) {
        self.localStorageRepository = localStorageRepository
    }
    
    public override func execute(_ params: Any?) -> AnyPublisher<MediaFile, Error> {
        return localStorageRepository.getData(key:.token).map { (value) -> MediaFile in
            return MediaFile(urlImage: "\(Configuration.baseURL)image?mediaPath=", urlFile: "\(Configuration.baseURL)mediafile?mediaPath=", token: value)
        }.eraseToAnyPublisher()
    }
}
