//
//  CategoryCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore
final class CategoryCell: GenericCell<HappyMindCore.Category> {
    override func setData(_ data: HappyMindCore.Category) {
        set(checked: data.isChecked)
        imageView.loadImage(data.imagePath.mediaPath) { (error) -> (Void) in
            DispatchQueue.main.async {
                self.addShadow(cornerRadius: 5)
                self.nameCategoryLabel.text = data.name
            }
        }
    }
}
