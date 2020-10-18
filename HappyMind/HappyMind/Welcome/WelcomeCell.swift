//
//  WelcomeCell.swift
//  HappyMind
//
//  Created by Carlos Pava on 18/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation
final class WelcomeCell: GenericCell<WelcomeObject> {
    override func setData(_ data: WelcomeObject) {
        nameCategoryLabel.text = data.title
    }
}
