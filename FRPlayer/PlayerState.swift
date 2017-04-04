//
//  PlayerState.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/31/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import AVFoundation

struct PlayerState {
    var status: AVPlayerStatus
    var timeControlStatus: AVPlayerTimeControlStatus
    var itemStatus: AVPlayerItemStatus
    var currentItem: AVPlayerItem
    var currentTime: Double
}
