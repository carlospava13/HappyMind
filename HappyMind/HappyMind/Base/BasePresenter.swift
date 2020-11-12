//
//  BasePresenter.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Combine

class BasePresenter: BasePresenterType {
    
    var subscriptions = Set<AnyCancellable>()

    weak var view: BaseView?

    func bind(_ view: BaseView) {
        self.view = view
    }

    deinit {
        self.view = nil
    }

    func viewDidLoad() {
        // This function left empty
    }
    
    func viewWillAppear() {
        // This function left empty
    }
}
