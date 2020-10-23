//
//  CMTime+Duration.swift
//  HappyMind
//
//  Created by Carlos Pava on 22/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import CoreMedia

extension CMTime {
    var durationText: String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let minutes: Int = Int(totalSeconds % 3600 / 60)
        let seconds: Int = Int((totalSeconds % 3600) % 60)
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
