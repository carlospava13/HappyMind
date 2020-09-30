//
//  GenericDinamic.swift
//  RapidApp
//
//  Created by Carlos Pava on 01/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

class GenericDinamic<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
