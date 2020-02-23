//
//  SwiftDepsState.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

// MARK: - State

public struct SwiftDepsState: Equatable {
    public var dependencies: [SwiftDeps]
}

// MARK: - Initial state

extension SwiftDepsState {
    static let initialState = SwiftDepsState(dependencies: [])
}

// MARK: - Actions

public enum SwiftDepsAction: Action {
    case parseFrom(paths: [URL])
    case set([SwiftDeps])
    case reset
    case failure(message: String)
}
