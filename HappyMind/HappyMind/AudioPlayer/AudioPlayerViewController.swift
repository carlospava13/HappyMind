//
//  AudioPlayerViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindData
import AVFoundation

final class AudioPlayerViewController: BaseViewController {

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var player: AVPlayer!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPlayButtonConstraints()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAudio()
    }

    func setupPlayButtonConstraints() {
        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }

    private func setAudio() {
        let url = URL(string: "http://www.samisite.com/sound/cropShadesofGrayMonkees.mp3")!
        let playerItem = CachingPlayerItem(url: url)
        playerItem.delegate = self
        player = AVPlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = false
    }

    @objc func onPlay() {
        DispatchQueue.main.async {
            self.player.play()
        }

    }
}

extension AudioPlayerViewController: AudioPlayerView {

}

extension AudioPlayerViewController: CachingPlayerItemDelegate {
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded and ready for storing")
    }

    func playerItem(_ playerItem: CachingPlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int) {
        print("\(bytesDownloaded)/\(bytesExpected)")
    }

    func playerItemPlaybackStalled(_ playerItem: CachingPlayerItem) {
        print("Not enough data for playback. Probably because of the poor network. Wait a bit and try to play later.")
    }

    func playerItem(_ playerItem: CachingPlayerItem, downloadingFailedWith error: Error) {
        print(error)
    }
    func progress(_ value: Float) {
        print(value)
    }
}
