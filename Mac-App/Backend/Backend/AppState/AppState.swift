//
//  AppState.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

public struct AppState: StateType {
    public let dependencyPathsState: DependencyPathsState
    public let swiftDepsState: SwiftDepsState
    public let dependencyGraphState: DependencyGraphState
    public let navigationState: NavigationState
}

// MARK: - Initial state

extension AppState {
    static let initialState = AppState(
        dependencyPathsState: DependencyPathsState.initialState,
        swiftDepsState: SwiftDepsState.initialState,
        dependencyGraphState: DependencyGraphState.initialState,
        navigationState: NavigationState.initialState
    )
}

// MARK: - Conformances

extension AppState: Equatable {}
