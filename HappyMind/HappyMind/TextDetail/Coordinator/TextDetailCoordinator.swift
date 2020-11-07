//
//  TextDetailCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import HappyMindCore

protocol TextDetailCoordinatorDelegate: AnyObject {

}

final class TextDetailCoordinator: BaseCoordinator {
    func start(theme: Theme) {
        let moduleInput = TextDetailConfigurator.ModuleInput(coordinator: self,
            theme: theme)
        let module = TextDetailConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }
}

extension TextDetailCoordinator: TextDetailCoordinatorDelegate {

}
