//
//  CoordinatorType.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get set }
    var router: RouterType { get }
    func start()
}
