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

    func calculateHeight(text: String, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: self],
            context: nil)
        return boundingBox.height
    }
    
    func height(text: String, withConstrainedWidth width: CGFloat) -> CGFloat {
          let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
          let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self], context: nil)

          return ceil(boundingBox.height)
      }
}
