//
//  PlayerManagerView.swift
//  HappyMind
//
//  Created by Carlos Pava on 24/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol PlayerManagerViewDelegate: AnyObject {
    func backward()
    func play()
    func pause()
    func forward()
}

final class PlayerManagerView: UIView {

    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_backward"), for: .normal)
        button.addTarget(self, action: #selector(onbBackward), for: .touchUpInside)
        return button
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_play"), for: .normal)
        button.setImage(UIImage(named: "btn_pause"), for: .selected)
        button.addTarget(self, action: #selector(onPlay(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_forward"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(onForward), for: .touchUpInside)
        return button
    }()

    weak var delegate: PlayerManagerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setPlayButtonConstraints()
        setBackwardConstraints()
        setForwardConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setPlayButtonConstraints() {
        addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: topAnchor),
            playButton.centerYAnchor.constraint(lessThanOrEqualTo: centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 85),
            playButton.heightAnchor.constraint(equalToConstant: 85)
            ])
    }

    private func setBackwardConstraints() {
        addSubview(backwardButton)
        NSLayoutConstraint.activate([
            backwardButton.centerYAnchor.constraint(lessThanOrEqualTo: playButton.centerYAnchor),
            backwardButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8),
            backwardButton.widthAnchor.constraint(equalToConstant: 60),
            backwardButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }

    private func setForwardConstraints() {
        addSubview(forwardButton)
        NSLayoutConstraint.activate([
            forwardButton.centerYAnchor.constraint(lessThanOrEqualTo: playButton.centerYAnchor),
            forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 8),
            forwardButton.widthAnchor.constraint(equalToConstant: 60),
            forwardButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }

    @objc func onbBackward() {
        delegate?.backward()
    }

    @objc func onPlay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if !sender.isSelected {
            delegate?.play()
        } else {
            delegate?.pause()
        }
    }

    @objc func onForward() {
        delegate?.forward()
    }
}
