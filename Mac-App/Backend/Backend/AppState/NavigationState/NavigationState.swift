//
//  NavigationState.swift
//  Backend
//
//  Created by Daniel Garcia on 14.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

// MARK: - State

public struct NavigationState: Equatable {
    var currentNode: Node
    var previousNode: Node?
}

// MARK: - Initial state

extension NavigationState {
    static let initialState = NavigationState(currentNode: .input, previousNode: nil)
}

// MARK: - Actions

public enum NavigationAction: Action {
    case transition(to: Node)
}

public enum Node {
    case input
    case mainScreen
}
