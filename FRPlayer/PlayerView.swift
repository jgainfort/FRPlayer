//
//  PlayerView.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/31/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxGesture
import RxAVFoundation

class PlayerView: UIView {
    
    let disposeBag = DisposeBag()
    
    var viewModel: PlayerViewModel?

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    func initPlayer(withUrl url: URL, autoPlay: Bool) {
        let item = AVPlayerItem(url: url)
        
        player = AVPlayer(playerItem: item)
        player?.playImmediately(atRate: autoPlay ? 1.0 : 0.0)
        
        addObservers()
    }
    
    func play() {
        if (player?.currentItem != nil) {
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        player?.rx.periodicTimeObserver(interval: interval)
            .subscribe(
                onNext: { [weak self] time in
                    self?.viewModel?.updateCurrentTime(time: time)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func addObservers() {
        addPeriodicTimeObserver()
        
        player?.rx.observe(AVPlayerStatus.self , "status")
            .subscribe(
                onNext: { [weak self] status in
                    guard let status = status else { return }
                    self?.viewModel?.updatePlayerStatus(status: status)
                }
            )
            .addDisposableTo(disposeBag)
        
        player?.rx.observe(AVPlayerTimeControlStatus.self, "timeControlStatus")
            .subscribe(
                onNext: { [weak self] status in
                    guard let status = status else { return }
                    self?.viewModel?.updatePlayerTimeControlStatus(status: status)
                }
            )
            .addDisposableTo(disposeBag)
        
        player?.rx.observe(AVPlayerItem.self, "currentItem")
            .subscribe(
                onNext: { [weak self] item in
                    guard let item = item else { return }
                    self?.viewModel?.updatePlayerItem(item: item)
                }
            )
            .addDisposableTo(disposeBag)
    
        player?.rx.observe(AVPlayerItemStatus.self, "currentItem.status")
            .subscribe(
                onNext: { [weak self] status in
                    guard let status = status else { return }
                    self?.viewModel?.updatePlayerItemStatus(status: status)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func removeObservers() {
        // remove any observers
    }

}
