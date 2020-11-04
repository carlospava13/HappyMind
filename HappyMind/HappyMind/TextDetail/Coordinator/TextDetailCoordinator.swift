//
//  TextDetailCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

protocol TextDetailCoordinatorDelegate: AnyObject {

}

final class TextDetailCoordinator: BaseCoordinator {
    override func start() {
        let moduleInput = TextDetailConfigurator.ModuleInput(coordinator: self)
        let module = TextDetailConfigurator.module(moduleInput: moduleInput)
        router.push(module, transition: .none, animated: true, completion: nil)
    }
}

extension TextDetailCoordinator: TextDetailCoordinatorDelegate {

}
