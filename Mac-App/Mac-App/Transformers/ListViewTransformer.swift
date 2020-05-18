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

final class ListViewTransformer {
    let stateObserver = StateObserver<Frontend.DependencyTree.Data>()
    private(set) var transformedData: Observable<Frontend.DependencyTree.State> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink {
            [weak self] appState in

            precondition(appState != nil, "State observer should always have an initial state provided by the Backend!")
            self?.emitNewData(appState!)
        }
    }

    func stopListening() {
        cancellable.cancel()
    }

    private func emitNewData(_ viewData: Frontend.DependencyTree.Data) {
        if viewData.dependencies.isEmpty == false {
            transformedData.update(to: .success(viewData: viewData))
        } else if let failure = viewData.failure {
            transformedData.update(to: .failure(failure))
        }
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension Frontend.DependencyTree.Data {
    init(appState: AppState) {
        self.init(
            dependencies: appState.dependencyGraphState.tree.map {
                DependencyTree.Data.Dependency(
                    owner: $0.owner,
                    dependencies: $0.dependencies.map { String($0.name) }
                )
            },
            failure: appState.dependencyGraphState.failure
        )
    }
}

extension Frontend.DependencyTree.Data: StateType {}
