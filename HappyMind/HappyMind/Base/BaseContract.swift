//
//  BaseContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

protocol BasePresenterType: AnyObject {
    var view: BaseView? { get }
    func bind(_ view: BaseView)
    func viewDidLoad()
    func viewWillAppear()
}

protocol BaseView: AnyObject {
    var presenter: BasePresenterType? { get }
    func show(_ message: String)
    func showSkeleton()
    func hideSkeleton()
}
