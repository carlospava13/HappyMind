//
//  BaseViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseView {
    private var loadingViewController: LoadingViewController?
    var presenter: BasePresenterType?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func setBackButtonItem(tintColor: UIColor = .gray) {
        let backbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let origImage = UIImage(named: "back_icon")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        backbutton.setImage(tintedImage, for: .normal)
        backbutton.tintColor = tintColor
        backbutton.addTarget(self, action: #selector(onBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }

    func show(_ message: String) {
        let alerViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerViewController.addAction(cancel)
        present(alerViewController, animated: true, completion: nil)
    }

    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showLoading() {
        loadingViewController = LoadingViewController()
        loadingViewController?.modalTransitionStyle = .crossDissolve
        loadingViewController?.modalPresentationStyle = .overCurrentContext
        present(loadingViewController!, animated: false, completion: nil)
    }

    func hideLoading() {
        loadingViewController?.dismiss(animated: false, completion: {
            self.loadingViewController = nil
        })
    }
}
