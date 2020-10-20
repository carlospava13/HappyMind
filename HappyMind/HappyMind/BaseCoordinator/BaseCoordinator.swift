//
//  BaseCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class BaseCoordinator: CoordinatorType {
    var childCoordinators: [CoordinatorType] = []
    var finishFlow: (() -> Void)?
    var router: RouterType
    weak var removeReferenceDelegete: RemoveReferenceDelegate?
    
    init(router: RouterType) {
        self.router = router
    }

    func start() {}

    func addDependency(_ coordinator: CoordinatorType) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: CoordinatorType?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func toPresent() -> UIViewController {
        let viewController = router.toPresent()
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
}

