//
//  ThemeCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 26/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class ThemeCell: GenericCell<HappyMindCore.Theme> {
    override func setData(_ data: HappyMindCore.Theme) {
        nameCategoryLabel.text = data.title
        imageView.loadImage(data.coverImage.mediaPath!) { (error) -> (Void) in
            DispatchQueue.main.async {
    
            }
        }
    }
}
