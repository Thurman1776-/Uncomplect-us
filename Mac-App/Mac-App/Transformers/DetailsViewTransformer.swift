//
//  DetailsViewTransformer.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Combine
import Frontend

final class DetailsViewTransformer {
    let stateObserver = StateObserver()
    private(set) var transformedData: ObservableData<ProjectFactsViewData.State> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink { [weak self] appState in self?.emitNewState(appState!) }
    }

    func stopListening() {
        cancellable.cancel()
    }

    private func emitNewState(_ state: AppState) {
        let viewData = mapAppStateToViewData(state)

        switch viewData {
        case let .failure(failure):
            transformedData.render(.failure(failure))
        case let .success(viewData):
            transformedData.render(.success(viewData: viewData))
        }
    }

    private func mapAppStateToViewData(_ appState: AppState) -> DetailsViewTransformer.Status {
        guard appState.dependencyGraphState.tree.count > 0 else {
            return .failure("No paths found!")
        }

        let heaviestDependency = appState.dependencyGraphState.tree.sorted(by: { first, second -> Bool in
            first.dependencies.count > second.dependencies.count
            }).first!.owner
        let totalDeps = appState.dependencyGraphState.tree.count
        let paths = appState.dependencyPathsState.paths

        let data = ProjectFactsViewData.Data(
            heaviestDependency: heaviestDependency,
            totalDependenciesFound: totalDeps,
            paths: paths
        )

        return .success(data)
    }
}

extension DetailsViewTransformer {
    enum Status {
        case success(_ data: ProjectFactsViewData.Data)
        case failure(_ failure: String)
    }
}
