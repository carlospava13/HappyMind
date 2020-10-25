//
//  UIFont+Calibri.swift
//  HappyMind
//
//  Created by Carlos Pava on 15/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

extension UIFont {
    static func calibriRegularFont(size: CGFloat = 18) -> UIFont? {
        return UIFont(name: "Calibri", size: size)
    }
    
    static func calibriBoldFont(size: CGFloat = 18) -> UIFont? {
        return UIFont(name: "Calibri-Bold", size: size)
    }
    
    static func JosefinSansRegularFont(size: CGFloat = 18) -> UIFont? {
        return UIFont(name: "JosefinSans-Regular", size: size)
    }
}
