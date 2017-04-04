//
//  ViewController.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/29/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift
import AVFoundation

class ViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var playerStatusLabel: UILabel!
    @IBOutlet weak var playerUrlLabel: UILabel!
    @IBOutlet weak var playerDurationLabel: UILabel!
    @IBOutlet weak var playerCurrentTimeLabel: UILabel!
    
    typealias StoreSubscriberStateType = State
    
    let disposeBag = DisposeBag()
    
    let playerStatus: Variable<String> = Variable("")
    let duration: Variable<String> = Variable("")
    let currentTime: Variable<String> = Variable("")
    let currentUrl: Variable<String> = Variable("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subscribe to redux store
        mainStore.subscribe(self)
        
        // bind properties to view
        playerStatus.asObservable()
            .distinctUntilChanged()
            .bindTo(playerStatusLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        duration.asObservable()
            .distinctUntilChanged()
            .bindTo(playerDurationLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        currentTime.asObservable()
            .distinctUntilChanged()
            .bindTo(playerCurrentTimeLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        currentUrl.asObservable()
            .distinctUntilChanged()
            .bindTo(playerUrlLabel.rx.text)
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // unscubscribe from redux store
        mainStore.unsubscribe(self)
    }
    
    func newState(state: State) {
        let playerState = state.playerState
        
        // update property values
        playerStatus.value = "\(playerState.status)"
        duration.value = "\(playerState.currentItem.duration.seconds)"
        currentTime.value = "\(playerState.currentTime)"
        
        if let asset = playerState.currentItem.asset as? AVURLAsset {
            currentUrl.value = asset.url.absoluteString
        }
    }

}

