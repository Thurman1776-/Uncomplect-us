//
//  ProjectDetailsTransformer.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Combine
import Frontend
import ReSwift

final class ProjectDetailsTransformer {
    let stateObserver = StateObserver<ProjectDetails.Data>()
    private(set) var transformedData: ObservableData<ProjectDetails.State> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink {
            [weak self] projectDetailsState in

            precondition(projectDetailsState != nil, "State observer should always have an initial state provided by the Backend!")
            self?.emitNewData(projectDetailsState!)
        }
    }

    func stopListening() {
        cancellable.cancel()
    }

    private func emitNewData(_ viewData: ProjectDetails.Data) {
        let status = mapViewDataToStatus(viewData)

        switch status {
        case let .failure(failure):
            transformedData.render(.failure(failure))
        case let .success(viewData):
            transformedData.render(.success(viewData: viewData))
        }
    }

    private func mapViewDataToStatus(_ data: ProjectDetails.Data) -> ProjectDetailsTransformer.Status {
        guard data.totalDependenciesFound > 0 else {
            return .failure("No paths found!")
        }

        return .success(data)
    }
}

extension ProjectDetailsTransformer {
    enum Status {
        case success(_ data: ProjectDetails.Data)
        case failure(_ failure: String)
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension ProjectDetails.Data {
    init(appState: AppState) {
        let heaviestDependency = appState.dependencyGraphState.tree.sorted(by: {
            first, second -> Bool in

            first.dependencies.count > second.dependencies.count
        }
        ).first?.owner
        let totalDeps = appState.dependencyGraphState.tree.count
        let paths = appState.dependencyPathsState.paths

        self.init(
            heaviestDependency: heaviestDependency ?? "",
            totalDependenciesFound: totalDeps,
            paths: paths
        )
    }
}

extension ProjectDetails.Data: StateType {}
