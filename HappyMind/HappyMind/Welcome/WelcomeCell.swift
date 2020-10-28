//
//  WelcomeCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
import HappyMindCore
final class WelcomeCell: GenericCell<Theme> {
    override func setData(_ data: Theme) {
        nameCategoryLabel.text = data.title
        indicator.startAnimating()
        imageView.loadImage(data.coverImage.mediaPath!) { (error) -> (Void) in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
}
