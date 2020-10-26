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

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .all
        setNavigationTransparent(backgroundColor: .black)
        setupPlayer()
    }

    func setupPlayer() {
        if let url = URL(string: "http://3.21.122.111/api/v1/mediafile?mediaPath=/themes/demo.mp4") {
            let avPlayer = AVPlayer(url: url)
            player = avPlayer
            avPlayer.play()
        }
    }
}
