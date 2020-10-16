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

    lazy var categoryRepository: CategoryRepositoryType = {
        CategoryRepository(service: service)
    }()
}
