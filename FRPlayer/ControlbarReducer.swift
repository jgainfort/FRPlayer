//
//  ControlbarReducer.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 4/3/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import ReSwift

func controlbarReducer(state: ControlbarState?, action: Action) -> ControlbarState {
    var state = state ?? initialControlbarState()
    
    switch action {
    case _ as ReSwiftInit:
        break
    case let action as ShowHideControlbar:
        state.hidden = action.hidden
    default:
        break
    }
    
    return state
}

func initialControlbarState() -> ControlbarState {
    return ControlbarState(hidden: false)
}
