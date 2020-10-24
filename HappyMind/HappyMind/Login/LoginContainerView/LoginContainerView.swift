//
//  LoginContainerView.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol LoginContainerDelegate: AnyObject {
    func login(email: String, password: String)
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
        label.font = UIFont.JosefinSansRegularFont(size: 30)
        label.textColor = .orange
        label.text = .localized(.happyMindTitle)
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = .localized(.email)
        textField.layer.cornerRadius = 10
        textField.font = UIFont.calibriRegularFont(size: 28)
        textField.addBorder()
        textField.addLeftPadding()
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = .localized(.password)
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.font = UIFont.calibriRegularFont(size: 28)
        textField.addBorder()
        textField.addLeftPadding()
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localized(.login), for: .normal)
        button.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        button.titleLabel?.font = UIFont.calibriRegularFont(size: 30)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()

    weak var delegate: LoginContainerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContainerViewConstraints()
        setImageViewConstraints()
        setStackViewConstraints()
        setLoginButtonConstraints()
        addTextFields()
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

    private func setImageViewConstraints() {
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
    }

    private func setStackViewConstraints() {
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 100)
            ])

    }
    
    private func setLoginButtonConstraints() {
        containerView.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 64),
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func addTextFields() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        ///stackView.addArrangedSubview(loginButton)
    }

    @objc private func onLogin() {
        delegate?.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
}
