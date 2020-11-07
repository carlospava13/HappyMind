//
//  TextDetailContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 3/11/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol TextDetailView: BaseView {
    func set(title: String)
    func set(image: String?)
    func set(textContent: String)
}

protocol TextDetailPresenterType: BasePresenterType {
    
}
