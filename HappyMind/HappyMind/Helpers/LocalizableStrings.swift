//
//  LocalizableStrings.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import UIKit
extension String {
    enum Localized: String {
        case happyMindTitle = "happymind"
        case email
        case password
        case login
        case welcome
        case skip
    }


    static func localized(_ key: Localized) -> String {
        return NSLocalizedString(key.rawValue, comment: "")
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

}

extension NSMutableAttributedString {
    
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            // not sure which is more reliable: String.Encoding.utf16 or String.Encoding.unicode
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString: attributedString)
    }
    
    func setFontSize(newSize: CGFloat) {
        beginEditing()
        self.enumerateAttribute(NSAttributedString.Key.font, in: NSRange(location: 0, length: self.length)) { (value, range, stop) in
            if let f = value as? UIFont {
                let newFont = f.withSize(newSize)
                removeAttribute(NSAttributedString.Key.font, range: range)
                addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
            }
        }
        endEditing()
    }
}
