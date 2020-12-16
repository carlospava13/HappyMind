//
//  VideoPlayerCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 25/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
import HappyMindData

final class VideoPlayerCoordinator: BaseCoordinator {
    
    private let theme: Theme
    
    init(router: RouterType,
        theme: Theme) {
        self.theme = theme
        super.init(router: router)
    }
    
    override func start() {
        let baseURl = Configuration.baseURL
        let videoPlayerViewController = VideoPlayerViewController()
        videoPlayerViewController.url = URL(string: "\(baseURl)mediafile?mediaPath=" + theme.mediaFile.mediaPath)
        router.push(videoPlayerViewController, transition: .none, animated: true, completion: nil)
    }
}
