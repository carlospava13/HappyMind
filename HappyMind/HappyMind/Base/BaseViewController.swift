//
//  BaseViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseView {
    
    var presenter: BasePresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func show(_ error: Error) {
        let alerViewController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerViewController.addAction(cancel)
        present(alerViewController, animated: true, completion: nil)
    }
}
