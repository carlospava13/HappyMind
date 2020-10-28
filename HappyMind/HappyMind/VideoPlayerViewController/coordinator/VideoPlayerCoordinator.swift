//
//  VideoPlayerCoordinator.swift
//  HappyMind
//
//  Created by Carlos Pava on 25/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore


final class VideoPlayerCoordinator: BaseCoordinator {
    
    private let theme: Theme
    
    init(router: RouterType,
        theme: Theme) {
        self.theme = theme
        super.init(router: router)
    }
    
    override func start() {
        let videoPlayerViewController = VideoPlayerViewController()
        videoPlayerViewController.url = URL(string: "http://3.21.122.111/api/v1/mediafile?mediaPath=" + theme.mediaFile.mediaPath)
        router.push(videoPlayerViewController, transition: .none, animated: true, completion: nil)
    }
}
