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
    let stateObserver = StateObserver<ProjectDetails.State>()
    private(set) var viewInput: Observable<ProjectDetails.Status> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink {
            [weak self] projectDetailsState in

            precondition(projectDetailsState != nil, "State observer should always have an initial state provided by the Backend!")
            self?.emitNewState(projectDetailsState!)
        }
    }

    func stopListening() {
        cancellable.cancel()
    }

    private func emitNewState(_ state: ProjectDetails.State) {
        let status = mapViewDataToStatus(state)

        switch status {
        case let .failure(failure):
            viewInput.update(to: .failure(failure))
        case let .success(viewData):
            viewInput.update(to: .success(viewData: viewData))
        }
    }

    private func mapViewDataToStatus(_ data: ProjectDetails.State) -> ProjectDetailsTransformer.Status {
        guard data.totalDependenciesFound > 0 else {
            return .failure("No paths found!")
        }

        return .success(data)
    }
}

extension ProjectDetailsTransformer {
    enum Status {
        case success(_ data: ProjectDetails.State)
        case failure(_ failure: String)
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension ProjectDetails.State {
    init(appState: AppState) {
        let heaviestDependency = appState.dependencyGraphState.tree.sorted(by: {
            first, second -> Bool in

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

extension ProjectDetails.State: StateType {}
