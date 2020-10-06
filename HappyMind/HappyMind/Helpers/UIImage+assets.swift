//
//  UIImage+assets.swift
//  HappyMind
//
//  Created by Carlos Pava on 6/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init(resource: AssetsResources) {
        self.init(named: resource.rawValue)!
    }
}
