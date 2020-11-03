//
//  VideoPlayerViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 25/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import AVKit
import Combine
import AVFoundation
import HappyMindData

final class VideoPlayerViewController: AVPlayerViewController {

    var url: URL?
    var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .all
        setNavigationTransparent(backgroundColor: .black)
        getToken()
    }

    func getToken() {
        LocalStorageRepository().getData(key: .token).sink { (completion) in
            
        } receiveValue: { (value: String) in
            self.setupPlayer(token: value)
        }.store(in: &subscriptions)
    }

    func setupPlayer(token: String) {
        if let url = self.url {
            let asset = AVURLAsset(url: url, options: ["AVURLAssetHTTPHeaderFieldsKey": ["Authorization": "Bearer \(token)"]])
            let playerItem = AVPlayerItem(asset: asset)
            let avPlayer = AVPlayer(playerItem: playerItem)

            player = avPlayer
            avPlayer.play()
        }
    }
}
