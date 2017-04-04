//
//  ControlbarViewController.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 4/3/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift
import RxAVFoundation
import AVFoundation

class ControlbarViewController: UIViewController {
    
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var topBarView: UIView!
    
    typealias StoreSubscriberStateType = State
    
    let disposeBag = DisposeBag()
    
    let viewModel: ControlbarViewModel = ControlbarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        addObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
        removeObservers()
    }
    
    private func addTapGestureRecognizer() {
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.viewModel.showHideControlbar(hidden: true)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func addObservers() {
        addTapGestureRecognizer()
        
        viewModel.timeRemaining.asObservable()
            .distinctUntilChanged()
            .bindTo(timeRemainingLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.progress.asObservable()
            .distinctUntilChanged()
            .bindTo(progressSlider.rx.value)
            .addDisposableTo(disposeBag)
    }
    
    private func removeObservers() {
        // remove any observers
    }

}
