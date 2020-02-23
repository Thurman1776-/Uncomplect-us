//
//  DependencyPathsState.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

// MARK: - State

public struct DependencyPathsState: Equatable {
    public var paths: [URL]
    public var failure: String?
}

// MARK: - Initial state

extension DependencyPathsState {
    static let initialState = DependencyPathsState(paths: [], failure: nil)
}

// MARK: - Actions

public enum DependencyPathsAction: Action {
    case findUrls(for: String)
    case append(paths: [URL])
    case remove(paths: [URL])
    case reset
    case failure(message: String)
}
