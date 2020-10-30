//
//  VolumeSliderView.swift
//  HappyMind
//
//  Created by Carlos Pava on 29/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import AVFoundation

protocol VolumeSliderViewDelage: AnyObject {
    func slider(_ value: Float)
}

final class VolumeSliderView: UIView {

    private lazy var imageLeftView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "speaker_left")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var imageRightView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "speaker_right")
        imageView.contentMode = .scaleAspectFit
        return imageView
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

    weak var delegate: VolumeSliderViewDelage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageLeftViewConstraints()
        setImageRightViewConstraints()
        setImageVolumeSliderConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setImageLeftViewConstraints() {
        addSubview(imageLeftView)
        NSLayoutConstraint.activate([
            imageLeftView.topAnchor.constraint(equalTo: topAnchor),
            imageLeftView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageLeftView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageLeftView.widthAnchor.constraint(equalToConstant: 30),
            ])
    }

    private func setImageRightViewConstraints() {
        addSubview(imageRightView)
        NSLayoutConstraint.activate([
            imageRightView.topAnchor.constraint(equalTo: topAnchor),
            imageRightView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageRightView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageRightView.widthAnchor.constraint(equalToConstant: 30)
            ])
    }

    private func setImageVolumeSliderConstraints() {
        addSubview(volumeSlider)
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(equalTo: topAnchor),
            volumeSlider.leadingAnchor.constraint(equalTo: imageLeftView.trailingAnchor, constant: 16),
            volumeSlider.trailingAnchor.constraint(equalTo: imageRightView.leadingAnchor, constant: -16),
            volumeSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }

    @objc func onSlider(_ sender: UISlider) {
        delegate?.slider(sender.value)
    }
}
