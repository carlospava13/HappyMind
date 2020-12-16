//
//  LoginContainerView.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol LoginContainerDelegate: AnyObject {
    func openSignIn()
}

final class LoginContainerView: UIView {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.JosefinSansRegularFont(size: 50)
        label.textColor = .orange
        label.text = .localized(.happyMindTitle)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.calibriBoldFont(size: 25)
        label.textColor = .gray
        label.text = "Inicia sesión con tu correo @sena.edu.co"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localized(.login), for: .normal)
        button.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        button.titleLabel?.font = UIFont.calibriRegularFont(size: 20)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .white
        button.setImage(UIImage(resource: .microsoft), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addBorderToView(color: .lightGray)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    weak var delegate: LoginContainerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContainerViewConstraints()
        setTitleLabelConstraints()
        setDescriptionLabelConstraints()
        setLoginButtonConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setContainerViewConstraints() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setTitleLabelConstraints() {
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setDescriptionLabelConstraints() {
        containerView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setLoginButtonConstraints() {
        containerView.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 80),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    @objc private func onLogin() {
        delegate?.openSignIn()
    }
}
