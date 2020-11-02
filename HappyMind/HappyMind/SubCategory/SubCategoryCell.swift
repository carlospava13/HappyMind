//
//  SubCategoryCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit
import HappyMindCore

final class SubCategoryCell: GenericCell<HappyMindCore.SubCategory> {
    override func setData(_ data: SubCategory) {
        nameCategoryLabel.text = data.name
        indicator.startAnimating()
        imageView.loadImage(data.mediaFile.mediaPath) { (error) -> (Void) in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
}
