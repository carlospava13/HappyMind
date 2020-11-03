//
//  AudioPlayerContract.swift
//  HappyMind
//
//  Created by Carlos Pava on 19/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

protocol AudioPlayerView: BaseView {
    func set(songTitle: String)
    func set(author: String)
    func set(urlSong: String, token: String)
    func set(imageUrl: String)
}

protocol AudioPlayerPresenterType: BasePresenterType {
    
}
