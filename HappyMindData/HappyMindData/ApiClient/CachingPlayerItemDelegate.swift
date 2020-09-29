//
//  CachingPlayerItemDelegate.swift
//  HappyMindData
//
//  Created by Carlos Pava on 28/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

@objc public protocol CachingPlayerItemDelegate {

    /// Is called when the media file is fully downloaded.
    @objc optional func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data)

    /// Is called every time a new portion of data is received.
    @objc optional func playerItem(_ playerItem: CachingPlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int)

    /// Is called after initial prebuffering is finished, means
    /// we are ready to play.
    @objc optional func playerItemReadyToPlay(_ playerItem: CachingPlayerItem)

    /// Is called when the data being downloaded did not arrive in time to
    /// continue playback.
    @objc optional func playerItemPlaybackStalled(_ playerItem: CachingPlayerItem)

    /// Is called on downloading error.
    @objc optional func playerItem(_ playerItem: CachingPlayerItem, downloadingFailedWith error: Error)
    
    @objc optional func progress(_ value: Float)

}
