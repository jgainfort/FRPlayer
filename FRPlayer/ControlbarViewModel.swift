//
//  ControlbarViewModel.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 4/4/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import ReSwift
import AVFoundation

class ControlbarViewModel: StoreSubscriber {
    
    let currentTime: Variable<String> = Variable("--:--")
    let timeRemaining: Variable<String> = Variable("--:--")
    let duration: Variable<Double> = Variable(0)
    let progress: Variable<Float> = Variable(0.0)
    let timeControlStatus: Variable<AVPlayerTimeControlStatus> = Variable(.waitingToPlayAtSpecifiedRate)
    
    let timeUtil: TimeUtil = TimeUtil()
    
    init() {
        mainStore.subscribe(self)
    }
    
    deinit {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: State) {
        let playerState = state.playerState
        
        currentTime.value = timeUtil.formatSecondsToString(seconds: playerState.currentTime)
        timeRemaining.value = timeUtil.formatSecondsToString(seconds: playerState.currentItem.duration.seconds - playerState.currentTime)
        duration.value = playerState.currentItem.duration.seconds
        progress.value = Float(playerState.currentTime / duration.value)
        timeControlStatus.value = playerState.timeControlStatus
    }
    
    func showHideControlbar(hidden: Bool) {
        mainStore.dispatch(ShowHideControlbar(hidden: hidden))
    }
    
}
