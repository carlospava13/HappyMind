//
//  VideoPlayerCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 25/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class VideoPlayerCoordinator: BaseCoordinator {
    override func start() {
        router.push(VideoPlayerViewController(), transition: .none, animated: true, completion: nil)
    }
}
