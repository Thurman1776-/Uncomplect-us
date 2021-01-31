//
//  DependencyGraphState.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

// MARK: - State

public struct DependencyGraphState: Equatable {
    public var list: [DependencyTree]
    public var filteredList: [DependencyTree] = []
    public var failure: String?
}

// MARK: - Initial state

extension DependencyGraphState {
    static let initialState = DependencyGraphState(list: [], failure: nil)
}

// MARK: - Actions

public enum DependencyGraphAction: Action {
    case mapFrom(deps: [SwiftDeps])
    case set([DependencyTree])
    case filter(including: String)
    case reset
    case failure(message: String)
}
