//
//  LoadingViewController.swift
//  HappyMind
//
//  Created by carlos pava on 17/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import Lottie

final class LoadingViewController: UIViewController {
    
    private lazy var animationView: AnimationView = {
        let view = AnimationView(name: "animation")
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.contentMode = .scaleAspectFill
        view.animationSpeed = 2
        view.loopMode = .loop
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAninamtionViewConstraints()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        animationView.play()
    }
    
    private func addAninamtionViewConstraints() {
        view.addSubview(animationView)
        let guides = view.safeAreaLayoutGuide
        let constraints: [NSLayoutConstraint] = [
            animationView.centerYAnchor.constraint(equalTo: guides.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: guides.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
