//
//  SwiftDepsReducer.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func swiftDepsReducer(action: Action, state: SwiftDepsState) -> SwiftDepsState {
    guard let swiftDepsAction = action as? SwiftDepsAction else {
        return state
    }

    var newState = state

    switch swiftDepsAction {
    case let .set(deps):
        newState = SwiftDepsState(dependencies: deps)
    case .reset:
        newState = SwiftDepsState.initialState
    default: break
    }

    return newState
}
