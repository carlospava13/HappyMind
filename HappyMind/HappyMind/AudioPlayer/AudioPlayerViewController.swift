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

    private lazy var diskView: DiskView = {
        let diskView = DiskView()
        diskView.translatesAutoresizingMaskIntoConstraints = false
        return diskView
    }()

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange()
        label.textAlignment = .center
        return label
    }()

    private lazy var playerManagerView: PlayerManagerView = {
        let playerManagerView = PlayerManagerView()
        playerManagerView.translatesAutoresizingMaskIntoConstraints = false
        playerManagerView.delegate = self
        return playerManagerView
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
    var timeObserverToken: Any?
    var obs: NSKeyValueObservation?
    var outputVolumeObserve: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor, UIColor.blue.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        setCircularProgressViewConstraints()
        setupDurationLabelConstraints()
        setPlayerManagerViewConstraints()
        setSliderConstraints()
        setAudio()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        diskView.layoutIfNeeded()
    }

    private func setCircularProgressViewConstraints() {
        view.addSubview(diskView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            diskView.centerYAnchor.constraint(equalTo: guides.centerYAnchor, constant: -100),
            diskView.centerXAnchor.constraint(equalTo: guides.centerXAnchor)
            ])
    }

    private func setupDurationLabelConstraints() {
        view.addSubview(durationLabel)
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: diskView.bottomAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: diskView.leadingAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: diskView.trailingAnchor),
            durationLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }

    private func setPlayerManagerViewConstraints() {
        view.addSubview(playerManagerView)
        NSLayoutConstraint.activate([
            playerManagerView.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 64),
            playerManagerView.centerXAnchor.constraint(equalTo: diskView.centerXAnchor),
            playerManagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerManagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    private func setSliderConstraints() {
        view.addSubview(volumeSlider)
        NSLayoutConstraint.activate([
            volumeSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
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
        player.automaticallyWaitsToMinimizeStalling = false
        let floatTime = Float(CMTimeGetSeconds(player.currentItem!.duration))
        diskView.setDuration(floatTime)

        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
            queue: .main) {
            [weak self] time in
            self?.durationLabel.text = time.durationText
            self?.diskView.currentTimer(time: Float(CMTimeGetSeconds(time)))
        }
    }

    @objc func onPlay() {
        let floatTime = Float(CMTimeGetSeconds(player.currentItem!.duration))
        diskView.setDuration(floatTime)
        player.play()
    }

    @objc func onPause() {
        player.pause()
    }

    @objc func onSlider(_ sender: UISlider) {
        player.volume = sender.value
    }

    private func moveCurrentTime(_ move: Float64) {
        if let duration = player.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime + move
            if newTime < CMTimeGetSeconds(duration)
            {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player.seek(to: selectedTime)
            }
            player.pause()
            player.play()
        }
    }
}

extension AudioPlayerViewController: AudioPlayerView {

}

extension AudioPlayerViewController: PlayerManagerViewDelegate {
    func backward() {
        moveCurrentTime(-5)
    }

    func play() {
        let floatTime = Float(CMTimeGetSeconds(player.currentItem!.duration))
        diskView.setDuration(floatTime)
        player.play()
    }

    func forward() {
        moveCurrentTime(5)
    }
}
