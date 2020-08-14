//
//  NavigationReducer.swift
//  Backend
//
//  Created by Daniel Garcia on 14.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func navigationReducer(action: Action, state: NavigationState) -> NavigationState {
    guard let swiftDepsAction = action as? NavigationAction else {
        return state
    }

    var newState = state

    switch swiftDepsAction {
    case let .transition(to: node):
        newState = applyTranstion(to: node, from: newState)
    }

    return newState
}

private func applyTranstion(to node: Node, from state: NavigationState) -> NavigationState {
    guard node != state.currentNode else { return state }

    return NavigationState(currentNode: node, previousNode: state.currentNode)
}
