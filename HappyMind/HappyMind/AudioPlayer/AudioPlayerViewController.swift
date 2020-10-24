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
    var timeObserverToken: Any?
    var obs: NSKeyValueObservation?
    var outputVolumeObserve: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setCircularProgressViewConstraints()
        setupDurationLabelConstraints()
        setupPlayButtonConstraints()
        setupPauseButtonConstraints()
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
            diskView.topAnchor.constraint(equalTo: guides.topAnchor),
            diskView.centerXAnchor.constraint(equalTo: guides.centerXAnchor)
            ])
    }

    private func setupDurationLabelConstraints() {
        view.addSubview(durationLabel)
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: diskView.bottomAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: diskView.leadingAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: diskView.trailingAnchor)
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
        player.automaticallyWaitsToMinimizeStalling = false


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
}

extension AudioPlayerViewController: AudioPlayerView {

}

