//
//  ApplicationViewController.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class ApplicationViewController: BaseViewController {
    
    private var ownPresenter: ApplicationPresenterType! {
        presenter as? ApplicationPresenterType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}

extension ApplicationViewController: ApplicationView {

}
