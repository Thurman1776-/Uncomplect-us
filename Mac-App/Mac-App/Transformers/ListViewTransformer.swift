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

final class ListViewTransformer {
    let stateObserver = StateObserver()
    private(set) var transformedData: ObservableData<DependencyTreeView.State> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink { [weak self] appState in self?.emitNewState(appState!) }
    }

    func stopListening() {
        cancellable.cancel()
    }

    private func emitNewState(_ newState: AppState) {
        let viewData = mapAppStateToViewData(newState)
        if viewData.dependencies.isEmpty == false {
            transformedData.render(.success(viewData: viewData))
        } else if let failure = newState.dependencyGraphState.failure {
            transformedData.render(.failure(failure))
        }
    }

    private func mapAppStateToViewData(_ appState: AppState) -> DependencyTreeView.Data {
        .init(dependencies: appState.dependencyGraphState.tree.map {
            DependencyTreeView.Data.Dependency(
                owner: $0.owner,
                dependencies: $0.dependencies.map { String($0.name) }
            )
        })
    }
}
