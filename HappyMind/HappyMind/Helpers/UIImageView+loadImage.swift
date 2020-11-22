//
//  UIImageView+loadImage.swift
//  HappyMind
//
//  Created by Carlos Pava on 21/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import SDWebImage
import HappyMindData

extension UIImageView {
    func loadImage(_ url: String, completion: @escaping (_ error: Error?) -> (Void)) {
        if let url = URL(string: "\(Configuration.baseURL)image?mediaPath=\(url)") {
            sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority) { (_, _, _, _) in
                completion(nil)
            }
        } else {
            completion(LoadImageError.notFound)
        }
    }
}

enum LoadImageError: Error {
    case notFound
}
