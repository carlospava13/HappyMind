//
//  Section.swift
//  HappyMind
//
//  Created by Carlos Pava on 30/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

class Section<Data> {
    var data: [Data]
    var title: String?

    init(data: [Data],
        title: String? = nil) {
        self.data = data
        self.title = title
    }
}
