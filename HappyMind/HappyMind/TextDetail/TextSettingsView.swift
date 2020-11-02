//
//  TextSettingsView.swift
//  HappyMind
//
//  Created by Carlos Pava on 31/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol TextSettingsViewDelegate: AnyObject {
    func set(size: Float)
    func set(darkMode: Bool)
}

final class TextSettingsView: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var sizeTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var lessButton: UIButton = {
        let button = UIButton()
        button.setTitle("A", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(onLessSizeText), for: .touchUpInside)
        return button
    }()

    private lazy var higherButton: UIButton = {
        let button = UIButton()
        button.setTitle("A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.addTarget(self, action: #selector(onHigherSizeText), for: .touchUpInside)
        return button
    }()

    private lazy var darkModeView: DarkModeView = {
        let darkModeView = DarkModeView()
        darkModeView.delegate = self
        return darkModeView
    }()
    
    weak var delegate: TextSettingsViewDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setStackViewConstraints()
        addSubViewsToStack()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor

        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        stackView.layer.cornerRadius = 10
        sizeTextStackView.layer.cornerRadius = 10
        setBorderLines(lessButton)
        setBorderLines(higherButton)
        setBorderLines(darkModeView)
    }

    private func setStackViewConstraints() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
            ])
    }

    private func addSubViewsToStack() {
        sizeTextStackView.addArrangedSubview(lessButton)
        sizeTextStackView.addArrangedSubview(higherButton)
        stackView.addArrangedSubview(sizeTextStackView)
        stackView.addArrangedSubview(darkModeView)

    }

    @objc func onLessSizeText() {
        delegate?.set(size: -1)
    }

    @objc func onHigherSizeText() {
        delegate?.set(size: 1)
    }
    
    func setBorderLines(_ view: UIView) {
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension TextSettingsView: DarkModeViewDelegate {
    func set(darkMode: Bool) {
        delegate?.set(darkMode: darkMode)
    }
}

protocol DarkModeViewDelegate: AnyObject {
    func set(darkMode: Bool)
}

final class DarkModeView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.overrideUserInterfaceStyle = .light
        label.text = "Modo nocturno"
        return label
    }()

    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(onSwitch(value:)), for: .allEvents)
        return switchView
    }()
    
    weak var delegate: DarkModeViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        switchView.isOn = traitCollection.userInterfaceStyle == .dark
        setStackViewViewConstraints()
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(switchView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }

    private func setStackViewViewConstraints() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    @objc func onSwitch(value: UISwitch) {
        delegate?.set(darkMode: value.isOn)
    }
}
