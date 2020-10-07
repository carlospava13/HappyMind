//
//  UITextField+Components.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding(value: CGFloat = 10) {
        let padding = CGRect(x: 0, y: 0, width: value, height: frame.size.height)
        leftView = UIView(frame: padding)
        leftViewMode = .always
    }

    func addBorder(color: UIColor = .gray) {
        layer.borderWidth = 0.25
        layer.borderColor = color.cgColor
    }
}
