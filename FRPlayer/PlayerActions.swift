//
//  PlayerActions.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/31/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import AVFoundation
import ReSwift

struct UpdatePlayerStatus: Action {
    let status: AVPlayerStatus
}

struct UpdateTimeControlStatus: Action {
    let status: AVPlayerTimeControlStatus
}

struct UpdatePlayerItemStatus: Action {
    let status: AVPlayerItemStatus
}

struct UpdatePlayerItem: Action {
    let item: AVPlayerItem
}

struct UpdatePlayerCurrentTime: Action {
    let currentTime: Double
}
