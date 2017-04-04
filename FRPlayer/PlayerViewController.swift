//
//  PlayerViewController.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/29/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import UIKit
import AVFoundation
import ReSwift
import RxSwift
import RxGesture

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var controlbarContainerView: UIView!
    
    typealias StoreSubscriberStateType = State
    
    let disposeBag = DisposeBag()
    
    let viewModel: PlayerViewModel = PlayerViewModel()
    
    override var prefersStatusBarHidden: Bool {
        return viewModel.controlbarHidden.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addObservers()
        
        if let url = URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8") {
            playerView.viewModel = viewModel
            playerView.initPlayer(withUrl: url, autoPlay: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        removeObservers()
    }
    
    private func addTapGestureRecognizer() {
        playerView.rx.tapGesture()
            .when(.recognized)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.viewModel.removeControlbarHiddenTimer()
                    self?.viewModel.showHideControlbar(hidden: false)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func addObservers() {
        addTapGestureRecognizer()
        viewModel.addControlbarHiddenTimer()
        
        viewModel.buffering.asObservable()
            .distinctUntilChanged()
            .map({ buffering in !buffering })
            .bindTo(activityIndicator.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        viewModel.controlbarHidden.asObservable()
            .distinctUntilChanged()
            .do(onNext: { [weak self] hidden in
                if !hidden {
                    self?.viewModel.removeControlbarHiddenTimer()
                    self?.viewModel.addControlbarHiddenTimer()
                }
                self?.setNeedsStatusBarAppearanceUpdate()
            })
            .bindTo(controlbarContainerView.rx.isHidden)
            .addDisposableTo(disposeBag)
    }
    
    private func removeObservers() {
        // remove any observers
        viewModel.removeControlbarHiddenTimer()
    }

}
