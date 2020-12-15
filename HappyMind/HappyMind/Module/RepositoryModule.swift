//
//  RepositoryModule.swift
//  HappyMind
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindData

final class RepositoryModule {

    private var service: BaseService

    init(service: BaseService) {
        self.service = service
    }

    lazy var loginRepository: LoginRepositoryType = {
        LoginRepository(service: service)
    }()

    lazy var localStorageRepository: LocalStorageRepositoryType = {
        LocalStorageRepository()
    }()

    lazy var categoryRepository: CategoryRepositoryType = {
        CategoryRepository(service: service)
    }()

    lazy var subcategoryRepository: SubCategoryRepositoryType = {
        SubCategoryRepository(service: service)
    }()

    lazy var themeRepository: ThemeRepositoryType = {
        ThemeRepository(service: service)
    }()

    lazy var welcomeRepository: WelcomeRepositoryType = {
        WelcomeRepositoty(service: service)
    }()

    lazy var checkThemeRepository: CheckThemeRepositoryType = {
        CheckThemeRepository(service: service)
    }()
    
    lazy var registerDeviceRepository: RegisterDeviceRepositoryType = {
       RegisterDeviceRepository(service: service)
    }()
}
