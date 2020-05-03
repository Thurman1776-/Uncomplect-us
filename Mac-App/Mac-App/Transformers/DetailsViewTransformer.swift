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
import ReSwift

final class DetailsViewTransformer {
    let stateObserver = StateObserver<ProjectFactsViewData.Data>()
    private(set) var transformedData: ObservableData<ProjectFactsViewData.State> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink { [weak self] appState in self?.emitNewData(appState!) }
    }

    func stopListening() {
        cancellable.cancel()
    }

    private func emitNewData(_ viewData: ProjectFactsViewData.Data) {
        let viewData = mapAppStateToViewData(viewData)

        switch viewData {
        case let .failure(failure):
            transformedData.render(.failure(failure))
        case let .success(viewData):
            transformedData.render(.success(viewData: viewData))
        }
    }

    private func mapAppStateToViewData(_ data: ProjectFactsViewData.Data) -> DetailsViewTransformer.Status {
        guard data.totalDependenciesFound > 0 else {
            return .failure("No paths found!")
        }

        return .success(data)
    }
}

extension DetailsViewTransformer {
    enum Status {
        case success(_ data: ProjectFactsViewData.Data)
        case failure(_ failure: String)
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension ProjectFactsViewData.Data {
    init(appState: AppState) {
        let heaviestDependency = appState.dependencyGraphState.tree.sorted(by: { first, second -> Bool in
            first.dependencies.count > second.dependencies.count
            }).first?.owner
        let totalDeps = appState.dependencyGraphState.tree.count
        let paths = appState.dependencyPathsState.paths

        self.init(
            heaviestDependency: heaviestDependency ?? "",
            totalDependenciesFound: totalDeps,
            paths: paths
        )
    }
}

extension ProjectFactsViewData.Data: StateType {}
