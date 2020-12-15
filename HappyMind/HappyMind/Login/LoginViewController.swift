//
//  LoginViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MSAL

final class LoginViewController: BaseViewController {
    
    let kClientID = "a251b868-7358-4356-95ab-031a1e8cce65"
    let kRedirectUri = "msauth.co.edu.sena.HappyMind://auth"
    let kAuthority = "https://login.microsoftonline.com/consumers"
    let kGraphEndpoint = "https://graph.microsoft.com/"

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loginbackground")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
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
        ownPresenter.bind(self)
        super.viewDidLoad()
        setBackgroundImageViewConstraints()
        setupScrollViewConstraints()
        setSenaImageViewConstraints()
        setLoginContainerViewConstraints()

    }

    private func setBackgroundImageViewConstraints() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func setupScrollViewConstraints() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func setSenaImageViewConstraints() {
        scrollView.addSubview(senaImageView)
        NSLayoutConstraint.activate([
            senaImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            senaImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            senaImageView.widthAnchor.constraint(equalToConstant: 117),
            senaImageView.heightAnchor.constraint(equalToConstant: 117)
            ])
    }

    private func setLoginContainerViewConstraints() {
        scrollView.addSubview(loginContainerView)
        NSLayoutConstraint.activate([
            loginContainerView.topAnchor.constraint(equalTo: senaImageView.bottomAnchor, constant: 64),
            loginContainerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            loginContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            loginContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
    }
}

extension LoginViewController: LoginView {

}

extension LoginViewController: LoginContainerDelegate {
    func login(email: String, password: String) {
        view.endEditing(true)
        SampleMSALAuthentication.shared.signInAccount(parentController: self, completion: {
            (account, token, error) in
            
            if let error = error {
                print("App error: \(error)")
                return
            }
            
            
        })
        //ownPresenter.setLogin(email: email, password: password)
    }
}
