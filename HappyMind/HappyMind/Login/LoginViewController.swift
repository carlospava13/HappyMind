//
//  LoginViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

final class LoginViewController: BaseViewController {

    private lazy var scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginContainerView: LoginContainerView = {
        let view = LoginContainerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private var ownPresenter: LoginPresenterType! {
        presenter as? LoginPresenterType
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ownPresenter.bind(self)
        setupScrollViewConstraints()
        setupContainerViewConstraints()
        setLoginContainerViewConstraints()
    }

    private func setupScrollViewConstraints() {
        view.addSubview(scrollView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guides.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guides.bottomAnchor)
            ])
    }

    private func setupContainerViewConstraints() {
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])
    }

    private func setLoginContainerViewConstraints() {
        containerView.addSubview(loginContainerView)
        NSLayoutConstraint.activate([
            loginContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
    }
}

extension LoginViewController: LoginView {

}

extension LoginViewController: LoginContainerDelegate {
    func login(email: String, password: String) {
        view.endEditing(true)
        ownPresenter.setLogin(email: email, password: password)
    }
}
