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

    private lazy var circularProgressView: CircularProgressView = {
        let circularProgressView = CircularProgressView()
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        return circularProgressView
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Puase", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(onPause), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isContinuous = true
        slider.tintColor = UIColor.blue
        slider.value = AVAudioSession.sharedInstance().outputVolume
        slider.addTarget(self, action: #selector(onSlider(_:)), for: .valueChanged)
        return slider
    }()

    var player: AVPlayer!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setCircularProgressViewConstraints()
        setupPlayButtonConstraints()
        setupPauseButtonConstraints()
        setSliderConstraints()
        setAudio()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circularProgressView.layoutIfNeeded()
    }

    private func setCircularProgressViewConstraints() {
        view.addSubview(circularProgressView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            circularProgressView.topAnchor.constraint(equalTo: guides.topAnchor),
            circularProgressView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            circularProgressView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            circularProgressView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }

    private func setupPlayButtonConstraints() {
        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupPauseButtonConstraints() {
        view.addSubview(pauseButton)
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalToSystemSpacingBelow: playButton.bottomAnchor, multiplier: 34),
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.widthAnchor.constraint(equalToConstant: 100),
            pauseButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }

    private func setSliderConstraints() {
        view.addSubview(volumeSlider)
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 32),
            volumeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            volumeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
    }

    private func setAudio() {
        let url = URL(string: "http://3.21.122.111/api/v1/mediafile?mediaPath=/themes/demo.mp3")!
        play(url: url)
    }

    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        player.volume = AVAudioSession.sharedInstance().outputVolume
    }

    @objc func onPlay() {
        //circularProgressView.progressAnimation(duration: 2)
        player.currentTime()
        let floatTime = Float(CMTimeGetSeconds(player.currentItem!.duration))
        circularProgressView.setDuration(floatTime)
        //circularProgressView.counter()
       player.play()
    }

    @objc func onPause() {
        player.pause()
        circularProgressView.pauseLayer()
    }

    @objc func onSlider(_ sender: UISlider) {
        player.volume = sender.value
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
