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

    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange()
        label.textAlignment = .center
        label.text = "00:00"
        return label
    }()

    private lazy var durationTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange()
        label.textAlignment = .center
        label.text = "00:00"
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
        slider.tintColor = .orange()
        slider.maximumTrackTintColor = .white
        slider.value = AVAudioSession.sharedInstance().outputVolume
        slider.addTarget(self, action: #selector(onSlider(_:)), for: .valueChanged)
        return slider
    }()

    private lazy var nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange()
        label.font = UIFont.calibriRegularFont()
        label.textAlignment = .center
        label.text = "Tu vida es aqui y ahora"
        return label
    }()

    private lazy var nameAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange()
        label.font = UIFont.calibriRegularFont()
        label.textAlignment = .center
        label.text = "Gilberto Gonzalez"
        return label
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
        setNameSongLabelConstraints()
        setNameAuthorLabelConstraints()
        setAudio()
    }

    private func setCircularProgressViewConstraints() {
        view.addSubview(diskView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            diskView.topAnchor.constraint(equalTo: guides.topAnchor, constant: 64),
            diskView.centerXAnchor.constraint(equalTo: guides.centerXAnchor),
            diskView.widthAnchor.constraint(lessThanOrEqualTo: guides.widthAnchor, multiplier: 0.7),
            diskView.heightAnchor.constraint(lessThanOrEqualTo: guides.widthAnchor, multiplier: 0.7)
            ])
        diskView.layoutIfNeeded()
    }

    private func setupDurationLabelConstraints() {
        view.addSubview(timeStackView)
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: diskView.bottomAnchor),
            timeStackView.leadingAnchor.constraint(equalTo: diskView.leadingAnchor),
            timeStackView.trailingAnchor.constraint(equalTo: diskView.trailingAnchor),
            timeStackView.heightAnchor.constraint(equalToConstant: 40)
            ])

        timeStackView.addArrangedSubview(currentTimeLabel)
        timeStackView.addArrangedSubview(durationTimeLabel)
    }

    private func setPlayerManagerViewConstraints() {
        view.addSubview(playerManagerView)
        NSLayoutConstraint.activate([
            playerManagerView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 16),
            playerManagerView.centerXAnchor.constraint(equalTo: diskView.centerXAnchor),
            playerManagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerManagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerManagerView.heightAnchor.constraint(equalToConstant: 85)
            ])
    }

    private func setSliderConstraints() {
        view.addSubview(volumeSlider)
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(equalTo: playerManagerView.bottomAnchor, constant: 32),
            volumeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            volumeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            volumeSlider.heightAnchor.constraint(equalToConstant: 20)
            ])
    }

    private func setNameSongLabelConstraints() {
        view.addSubview(nameSongLabel)
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 16),
            nameSongLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameSongLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameSongLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }

    private func setNameAuthorLabelConstraints() {
        view.addSubview(nameAuthorLabel)
        NSLayoutConstraint.activate([
            nameAuthorLabel.topAnchor.constraint(equalTo: nameSongLabel.bottomAnchor, constant: 16),
            nameAuthorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameAuthorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameAuthorLabel.heightAnchor.constraint(equalToConstant: 20),
//            nameAuthorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
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
            self?.currentTimeLabel.text = time.durationText
            self?.diskView.currentTimer(time: Float(CMTimeGetSeconds(time)))
        }
    }

    @objc func onPlay() {
        let floatTime = Float(CMTimeGetSeconds(player.currentItem!.duration))
        durationTimeLabel.text = player.currentItem?.duration.durationText
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
