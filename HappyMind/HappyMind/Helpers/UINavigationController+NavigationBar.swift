//
//  UINavigationController+NavigationBar.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

extension UIViewController {
    func setNavigationTransparent(title: String? = nil, backgroundColor: UIColor = .clear) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.backgroundColor = backgroundColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        self.title = title
    }

    func setFontNavigationBar(font: UIFont = UIFont.JosefinSansRegularFont()!, color: UIColor = .white) {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font]
       
    }
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController {
        return self
    }
}
