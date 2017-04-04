//
//  PlayerViewModel.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 4/4/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift
import AVFoundation

class PlayerViewModel: StoreSubscriber {
    
    let buffering: Variable<Bool> = Variable(true)
    let controlbarHidden: Variable<Bool> = Variable(true)
    var controlbarHiddenTimer: Disposable?
    
    init() {
        mainStore.subscribe(self)
    }
    
    deinit {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: State) {
        let playerState = state.playerState
        let controlbarState = state.controlbarState
        
        setBufferState(item: playerState.currentItem)
        
        controlbarHidden.value = controlbarState.hidden
    }
    
    func showHideControlbar(hidden: Bool) {
        mainStore.dispatch(ShowHideControlbar(hidden: hidden))
    }
    
    func updatePlayerStatus(status: AVPlayerStatus) {
        mainStore.dispatch(UpdatePlayerStatus(status: status))
    }
    
    func updatePlayerTimeControlStatus(status: AVPlayerTimeControlStatus) {
        mainStore.dispatch(UpdateTimeControlStatus(status: status))
    }
    
    func updatePlayerItem(item: AVPlayerItem) {
        mainStore.dispatch(UpdatePlayerItem(item: item))
    }
    
    func updatePlayerItemStatus(status: AVPlayerItemStatus) {
        mainStore.dispatch(UpdatePlayerItemStatus(status: status))
    }
    
    func updateCurrentTime(time: CMTime) {
        mainStore.dispatch(UpdatePlayerCurrentTime(currentTime: time.seconds))
    }
    
    func addControlbarHiddenTimer() {
        let startTime = RxTimeInterval(10)
        let interval = RxTimeInterval(10)
        
        controlbarHiddenTimer = Observable<Int>.timer(startTime, period: interval, scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.showHideControlbar(hidden: false)
                    self?.removeControlbarHiddenTimer()
                }
        )
    }
    
    func removeControlbarHiddenTimer() {
        controlbarHiddenTimer?.dispose()
    }
    
    private func setBufferState(item: AVPlayerItem) {
        if item.isPlaybackBufferEmpty {
            buffering.value = true
        } else if item.isPlaybackBufferFull || item.isPlaybackLikelyToKeepUp {
            buffering.value = false
        }
    }
    
}
