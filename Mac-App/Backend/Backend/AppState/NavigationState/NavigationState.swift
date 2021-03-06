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
    public var currentNode: Node
    public var previousNode: Node?
}

// MARK: - Initial state

extension NavigationState {
    static let initialState = NavigationState(currentNode: .startup, previousNode: nil)
}

// MARK: - Actions

public enum NavigationAction: Action {
    case transition(to: Node)
}

public enum Node {
    case startup
    case input
    case mainScreen
}
