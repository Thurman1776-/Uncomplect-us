//
//  DependencyGraphReducer.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func dependencyGraphReducer(action: Action, state: DependencyGraphState) -> DependencyGraphState {
    guard let swiftDepsAction = action as? DependencyGraphAction else {
        return state
    }

    var newState = state

    switch swiftDepsAction {
    case let .set(deps):
        newState = DependencyGraphState(tree: deps)
    case .reset:
        newState = DependencyGraphState.initialState
    case let .failure(message: message):
        newState.failure = message
    default: break
    }

    return newState
}
