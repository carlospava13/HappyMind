//
//  TextDetailViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 31/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class TextDetailViewController: BaseViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange()
        label.font = UIFont.calibriBoldFont(size: 30)
        label.text = "Disfruta tu comida con consciencia"
        label.numberOfLines = 0
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "background")
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr termina aqui"
        label.font = UIFont.calibriBoldFont(size: 19)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    private lazy var textSettingsView: TextSettingsView = {
        let textSettingsView = TextSettingsView(frame: CGRect(x: UIScreen.main.bounds.width - 220, y: 0, width: 220, height: 80))
        textSettingsView.delegate = self
        textSettingsView.isHidden = true
        return textSettingsView
    }()

    private var heightConstraints: NSLayoutConstraint!
    var sizeDefault: Float = 19.0
    private var toogle = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollViewConstraints()
        setTitleLabelConstraints()
        setImageViewConstraints()
        setTextViewConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "AA",
            style: .plain,
            target: self,
            action: #selector(onShowTextSettings))
        set(darkMode: overrideUserInterfaceStyle == .dark)
        scrollView.addSubview(textSettingsView)
        setBackButtonItem(tintColor: .gray)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculateHeight()
    }

    private func setScrollViewConstraints() {
        view.addSubview(scrollView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guides.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guides.bottomAnchor)
            ])
    }

    private func setTitleLabelConstraints() {
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ])
    }

    private func setImageViewConstraints() {
        scrollView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }

    private func setTextViewConstraints() {
        scrollView.addSubview(textLabel)
        heightConstraints = textLabel.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            heightConstraints
            ])
    }

    @objc func onShowTextSettings() {
        if textSettingsView.isHidden {
            textSettingsView.isHidden = false
            textSettingsView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.textSettingsView.alpha = 1
            }
        } else {
            textSettingsView.isHidden = true
        }
        toogle = !toogle
    }

    func calculateHeight() {
        let height = textLabel.font?.height(text: textLabel.text!, withConstrainedWidth: textLabel.bounds.width)
        heightConstraints.constant = height! * 1.3
        view.updateConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        set(darkMode: userInterfaceStyle == .dark)
        textSettingsView.set(state: userInterfaceStyle == .dark)
    }
}

extension TextDetailViewController: TextSettingsViewDelegate {
    func set(size: Float) {
        sizeDefault += size
        textLabel.font = UIFont.calibriRegularFont(size: CGFloat(sizeDefault))
        calculateHeight()
    }

    func set(darkMode: Bool) {
        let color: UIColor = darkMode ? .black : .white
        view.backgroundColor = color
        setNavigationTransparent(backgroundColor: color)
        textLabel.textColor = darkMode ? .white : .black
    }
}

extension TextDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textSettingsView.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 220, y: scrollView.contentOffset.y)
        textSettingsView.isHidden = true
    }
}
