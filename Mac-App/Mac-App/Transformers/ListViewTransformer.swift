//
//  ListViewTransformer.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Combine
import Frontend
import ReSwift

final class ListViewTransformer: StateTransforming, StateRepresentableViewInput, StateSubscription {
    let stateObserver = StateObserver<Frontend.DependencyTree.State>(state: DependencyTree.State.initialState)
    private(set) var viewInput: Observable<Frontend.DependencyTree.Status> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink { [weak self] in self?.emitNewState($0) }
    }

    func stopListening() {
        cancellable.cancel()
    }

    func emitNewState(_ state: Frontend.DependencyTree.State) {
        if state.dependencies.isEmpty == false {
            viewInput.update(to: .success(state: state))
        } else if let failure = state.failure {
            viewInput.update(to: .failure(failure))
        }
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension Frontend.DependencyTree.State {
    init(appState: AppState) {
        self.init(
            dependencies: appState.dependencyGraphState.tree.map {
                DependencyTree.State.Dependency(
                    owner: $0.owner,
                    dependencies: $0.dependencies.map { String($0.name) }
                )
            },
            filteredDependencies: appState.dependencyGraphState.filteredTree.map {
                DependencyTree.State.Dependency(
                    owner: $0.owner,
                    dependencies: $0.dependencies.map { String($0.name) }
                )
            },
            failure: appState.dependencyGraphState.failure
        )
    }
}

extension Frontend.DependencyTree.State: StateType {}
extension Frontend.DependencyTree.State {
    static let initialState = DependencyTree.State(dependencies: [], filteredDependencies: [], failure: nil)
}
