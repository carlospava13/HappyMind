//
//  InteractorModule.swift
//  HappyMind
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore

final class InteractorModule {

    private var repositoryModule: RepositoryModule

    init(repositoryModule: RepositoryModule) {
        self.repositoryModule = repositoryModule
    }

    lazy var loginInteractor: LoginInteractor = {
        LoginInteractor(repository: repositoryModule.loginRepository,
            localStorageRepository: repositoryModule.localStorageRepository)
    }()

    lazy var firstTimeInteractor: FirstTimeInteractor = {
        FirstTimeInteractor(repository: repositoryModule.localStorageRepository)
    }()
    
    lazy var setFirstTimeInteractor: SetFirstTimeInteractor = {
        SetFirstTimeInteractor(repository: repositoryModule.localStorageRepository)
    }()

    lazy var getCategoriesInteractor: GetCategoriesInteractor = {
        GetCategoriesInteractor(repository: repositoryModule.categoryRepository)
    }()
    
    lazy var getSubCatogoryInteractor: GetSubCatogoryInteractor = {
        GetSubCatogoryInteractor(repository: repositoryModule.subcategoryRepository)
    }()
    
    lazy var getThemeInteractor: GetThemeInteractor = {
        GetThemeInteractor(repository: repositoryModule.themeRepository)
    }()
}
