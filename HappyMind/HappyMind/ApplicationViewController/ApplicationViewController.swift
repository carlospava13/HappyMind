//
//  ApplicationViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class ApplicationViewController: BaseViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "splash")
        return imageView
    }()

    private var ownPresenter: ApplicationPresenterType! {
        presenter as? ApplicationPresenterType
    }

    override func viewDidLoad() {
        ownPresenter.bind(self)
        view.backgroundColor = .white
        super.viewDidLoad()
        setImageViewConstraints()
    }
    
    private func setImageViewConstraints() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ApplicationViewController: ApplicationView {

}
