//
//  VideoPlayerViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 25/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import AVKit
import AVFoundation

final class VideoPlayerViewController: AVPlayerViewController {
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .all
        setNavigationTransparent(backgroundColor: .black)
        setupPlayer()
    }

    func setupPlayer() {
        if let url = self.url {
            let avPlayer = AVPlayer(url: url)
            player = avPlayer
            avPlayer.play()
        }
    }
}
