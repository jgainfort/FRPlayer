//
//  AppReducer.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 3/31/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import ReSwift

struct AppReducer: Reducer {
    
    typealias ReducerStateType = State
    
    func handleAction(action: Action, state: State?) -> State {
        return State(
            playerState: playerReducer(state: state?.playerState, action: action),
            controlbarState: controlbarReducer(state: state?.controlbarState, action: action)
        )
    }
    
}
