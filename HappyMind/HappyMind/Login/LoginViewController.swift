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
        return scrollView
    }()

    private lazy var loginImageBackgroundView: LoginImageBackgroundView = {
        let view = LoginImageBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var senaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "iconSena")
        return imageView
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
        setLoginImageBackgroundView()
        setupScrollViewConstraints()
        setSenaImageViewConstraints()
//        setupContainerViewConstraints()
        setLoginContainerViewConstraints()
    }

    private func setLoginImageBackgroundView() {
        view.addSubview(loginImageBackgroundView)
        NSLayoutConstraint.activate([
            loginImageBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            loginImageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginImageBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginImageBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    private func setupScrollViewConstraints() {
        loginImageBackgroundView.addSubview(scrollView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guides.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guides.bottomAnchor)
            ])
    }

    private func setSenaImageViewConstraints() {
        scrollView.addSubview(senaImageView)
        NSLayoutConstraint.activate([
            senaImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 190),
            senaImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            senaImageView.widthAnchor.constraint(equalToConstant: 100),
            senaImageView.heightAnchor.constraint(equalToConstant: 100)
            ])
    }

    private func setLoginContainerViewConstraints() {
        scrollView.addSubview(loginContainerView)
        NSLayoutConstraint.activate([
            loginContainerView.topAnchor.constraint(equalTo: senaImageView.bottomAnchor, constant: 16),
            loginContainerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            loginContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            loginContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 190)
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
