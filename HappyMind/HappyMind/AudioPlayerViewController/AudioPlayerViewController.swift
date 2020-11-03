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

    private lazy var imageBackgroundView: BackgroundImageView = {
        let view = BackgroundImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onBack), for: .touchUpInside)
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()

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
        label.font = UIFont.calibriRegularFont(size: 28)
        return label
    }()

    private lazy var durationTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange()
        label.textAlignment = .center
        label.text = "00:00"
        label.font = UIFont.calibriRegularFont(size: 28)
        return label
    }()

    private lazy var playerManagerView: PlayerManagerView = {
        let playerManagerView = PlayerManagerView()
        playerManagerView.translatesAutoresizingMaskIntoConstraints = false
        playerManagerView.delegate = self
        return playerManagerView
    }()

    private lazy var volumeSlider: VolumeSliderView = {
        let volumeSliderView = VolumeSliderView()
        volumeSliderView.delegate = self
        volumeSliderView.translatesAutoresizingMaskIntoConstraints = false
        return volumeSliderView
    }()

    private lazy var nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange()
        label.font = UIFont.calibriBoldFont(size: 28)
        label.textAlignment = .center
        return label
    }()

    private lazy var nameAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange()
        label.font = UIFont.calibriRegularFont(size: 28)
        label.textAlignment = .center
        return label
    }()

    private var ownPresenter: AudioPlayerPresenterType! {
        presenter as? AudioPlayerPresenterType
    }

    private var player: AVPlayer?
    private var playerItemContext = 0
    private var timeObserverToken: Any?

    override func viewDidLoad() {
        ownPresenter.bind(self)
        view.backgroundColor = .white
        setImageBackgroundViewConstraints()
        setCircularProgressViewConstraints()
        setupDurationLabelConstraints()
        setPlayerManagerViewConstraints()
        setSliderConstraints()
        setNameSongLabelConstraints()
        setNameAuthorLabelConstraints()

        setBackButtonConstraints()
        super.viewDidLoad()
    }

    deinit {
        player = nil
        timeObserverToken = nil
    }

    private func setImageBackgroundViewConstraints() {
        view.addSubview(imageBackgroundView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackgroundView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            imageBackgroundView.bottomAnchor.constraint(equalTo: guides.bottomAnchor)
            ])
    }

    private func setBackButtonConstraints() {
        imageBackgroundView.addSubview(backButton)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: guides.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setCircularProgressViewConstraints() {
        imageBackgroundView.addSubview(diskView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            diskView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 60),
            diskView.centerXAnchor.constraint(equalTo: guides.centerXAnchor),
            diskView.leadingAnchor.constraint(equalTo: guides.leadingAnchor, constant: 58),
            diskView.trailingAnchor.constraint(equalTo: guides.trailingAnchor, constant: -58)
            ])
    }

    private func setupDurationLabelConstraints() {
        imageBackgroundView.addSubview(timeStackView)
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(greaterThanOrEqualTo: diskView.bottomAnchor, constant: 16),
            timeStackView.leadingAnchor.constraint(equalTo: diskView.leadingAnchor),
            timeStackView.trailingAnchor.constraint(equalTo: diskView.trailingAnchor),
            timeStackView.heightAnchor.constraint(equalToConstant: 40)
            ])

        timeStackView.addArrangedSubview(currentTimeLabel)
        timeStackView.addArrangedSubview(durationTimeLabel)
    }

    private func setPlayerManagerViewConstraints() {
        imageBackgroundView.addSubview(playerManagerView)
        NSLayoutConstraint.activate([
            playerManagerView.topAnchor.constraint(greaterThanOrEqualTo: timeStackView.bottomAnchor, constant: 16),
            playerManagerView.centerXAnchor.constraint(equalTo: diskView.centerXAnchor),
            playerManagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerManagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerManagerView.heightAnchor.constraint(equalToConstant: 85)
            ])
    }

    private func setSliderConstraints() {
        imageBackgroundView.addSubview(volumeSlider)
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(greaterThanOrEqualTo: playerManagerView.bottomAnchor, constant: 16),
            volumeSlider.leadingAnchor.constraint(equalTo: diskView.leadingAnchor),
            volumeSlider.trailingAnchor.constraint(equalTo: diskView.trailingAnchor),
            volumeSlider.heightAnchor.constraint(equalToConstant: 20)
            ])
    }

    private func setNameSongLabelConstraints() {
        imageBackgroundView.addSubview(nameSongLabel)
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 16),
            nameSongLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameSongLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameSongLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setNameAuthorLabelConstraints() {
        imageBackgroundView.addSubview(nameAuthorLabel)
        NSLayoutConstraint.activate([
            nameAuthorLabel.topAnchor.constraint(equalTo: nameSongLabel.bottomAnchor, constant: 16),
            nameAuthorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameAuthorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameAuthorLabel.heightAnchor.constraint(equalToConstant: 30),
            nameAuthorLabel.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -120       )
            ])
    }

    private func play(url: URL, token: String) {
        let asset = AVURLAsset(url: url, options: ["AVURLAssetHTTPHeaderFieldsKey": ["Authorization": "Bearer \(token)"]])
        let playerItem = AVPlayerItem(asset: asset)
        //let playerItem = AVPlayerItem(url: url)
        playerItem.addObserver(self,
            forKeyPath: #keyPath(AVPlayerItem.status),
            options: [.old, .new],
            context: &playerItemContext)
        self.player = AVPlayer(playerItem: playerItem)
        player?.volume = AVAudioSession.sharedInstance().outputVolume
        player?.automaticallyWaitsToMinimizeStalling = false
        let floatTime = Float(CMTimeGetSeconds(player!.currentItem!.duration))
        diskView.setDuration(floatTime)

        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: time,
            queue: .main) {
            [weak self] time in
            self?.currentTimeLabel.text = time.durationText
            self?.diskView.currentTimer(time: Float(CMTimeGetSeconds(time)))
        }
    }

    @objc func onPlay() {
        player?.play()
    }

    @objc func onPause() {
        player?.pause()
    }

    @objc func onBack() {
        dismiss(animated: true, completion: nil)
    }

    private func moveCurrentTime(_ move: Float64) {
        if let duration = player?.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime + move
            if newTime < CMTimeGetSeconds(duration)
            {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player?.seek(to: selectedTime)
            }
            player?.pause()
            player?.play()
        }
    }

    override func observeValue(forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?) {
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                of: object,
                change: change,
                context: context)
            return
        }

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            // Switch over status value
            switch status {
            case .readyToPlay:
                if let player = self.player {
                    let floatTime = Float(CMTimeGetSeconds(player.currentItem!.duration))
                    durationTimeLabel.text = player.currentItem?.duration.durationText
                    diskView.setDuration(floatTime)
                    player.play()
                }
                break
            case .failed:
                print("failed")
                break
            case .unknown:
                print("failed")
                break
            @unknown default:
                fatalError()
            }
        }
    }
}

extension AudioPlayerViewController: VolumeSliderViewDelage {
    func slider(_ value: Float) {
        player?.volume = value
    }
}

extension AudioPlayerViewController: AudioPlayerView {
    func set(songTitle: String) {
        nameSongLabel.text = songTitle
    }

    func set(author: String) {
        nameAuthorLabel.text = author
    }

    func set(urlSong: String, token: String) {
        if let url = URL(string: urlSong) {
            play(url: url, token: token)
        }
    }

    func set(imageUrl: String) {
        imageBackgroundView.set(imageUrl: imageUrl)
        diskView.set(imageUrl: imageUrl) 
    }
}

extension AudioPlayerViewController: PlayerManagerViewDelegate {
    func backward() {
        moveCurrentTime(-15)
    }

    func play() {
        let floatTime = Float(CMTimeGetSeconds(player!.currentItem!.duration))
        diskView.setDuration(floatTime)
        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func forward() {
        moveCurrentTime(15)
    }
}
