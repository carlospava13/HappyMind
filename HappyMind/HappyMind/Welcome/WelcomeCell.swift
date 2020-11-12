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
        set(checked: data.isChecked)
        imageView.loadImage(data.coverImage.mediaPath!) { _ in }
        nameCategoryLabel.text = data.title
    }
}
