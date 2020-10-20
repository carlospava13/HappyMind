//
//  RemoveReferenceDelegate.swift
//  HappyMind
//
//  Created by Carlos Pava on 20/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol RemoveReferenceDelegate: AnyObject {
    func removeReference(_ coodinator: BaseCoordinator)
}
