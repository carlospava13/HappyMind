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

    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "toplogin")
        return imageView
    }()

    private lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "bottomlogin")
        return imageView
    }()

    private lazy var scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
        setupScrollViewConstraints()
        setTopImageViewConstraints()
        setBottomImageViewConstraints()
        setSenaImageViewConstraints()
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

    private func setTopImageViewConstraints() {
        view.addSubview(topImageView)
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topImageView.heightAnchor.constraint(equalToConstant: 100)
            ])
    }

    private func setBottomImageViewConstraints() {
        scrollView.addSubview(bottomImageView)
        NSLayoutConstraint.activate([
            bottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomImageView.heightAnchor.constraint(equalToConstant: 100)
            ])
    }

    private func setSenaImageViewConstraints() {
        scrollView.addSubview(senaImageView)
        NSLayoutConstraint.activate([
            senaImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:  120),
            senaImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            senaImageView.widthAnchor.constraint(equalToConstant: 80),
            senaImageView.heightAnchor.constraint(equalToConstant: 80)
            ])
    }

    private func setLoginContainerViewConstraints() {
        scrollView.addSubview(loginContainerView)
        NSLayoutConstraint.activate([
            loginContainerView.topAnchor.constraint(equalTo: senaImageView.bottomAnchor, constant: 32),
            loginContainerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
           // loginContainerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            loginContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            loginContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            loginContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100)
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
