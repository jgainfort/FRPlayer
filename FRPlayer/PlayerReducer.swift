//
//  PlayerReducer.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/31/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import AVFoundation
import ReSwift

func playerReducer(state: PlayerState?, action: Action) -> PlayerState {
    var state = state ?? initialPlayerState()
    
    switch action {
    case _ as ReSwiftInit:
        break
    case let action as UpdatePlayerStatus:
        state.status = action.status
    case let action as UpdateTimeControlStatus:
        state.timeControlStatus = action.status
    case let action as UpdatePlayerItemStatus:
        state.itemStatus = action.status
    case let action as UpdatePlayerItem:
        state.currentItem = action.item
    case let action as UpdatePlayerCurrentTime:
        state.currentTime = action.currentTime
    default:
        break
    }
    
    return state
}

func initialPlayerState() -> PlayerState {
    let url = URL(string: "nil")!
    let item = AVPlayerItem(url: url)
    return PlayerState(status: .unknown, timeControlStatus: .waitingToPlayAtSpecifiedRate, itemStatus: .unknown, currentItem: item, currentTime: -1)
}
