//
//  DependencyPathsReducer.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func dependencyPathsReducer(action: Action, state: DependencyPathsState) -> DependencyPathsState {
    guard let dependencyPathsAction = action as? DependencyPathsAction else {
        return state
    }

    var newState = state

    switch dependencyPathsAction {
    case .findUrls:
        newState = DependencyPathsState.initialState
    case let .append(paths: paths):
        newState.paths = newState.paths + paths
    case let .remove(paths: paths):
        let newPaths = newState.paths.filter { paths.contains($0) == false }
        newState.paths = newPaths
    case .reset:
        newState = DependencyPathsState.initialState
    case let .failure(message):
        newState.failure = message
    }

    return newState
}
