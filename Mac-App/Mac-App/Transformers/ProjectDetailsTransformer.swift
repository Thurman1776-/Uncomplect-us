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

final class ProjectDetailsTransformer: StateTransforming, StateRepresentableViewInput, StateSubscription {
    let stateObserver = StateObserver<ProjectDetails.State>(state: ProjectDetails.State.initialState)
    private(set) var viewInput: Observable<ProjectDetails.Status> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    func startListening() {
        cancellable = stateObserver.$currentState.sink { [unowned self] in self.emitNewState($0) }
    }

    func stopListening() {
        cancellable.cancel()
    }

    func emitNewState(_ state: ProjectDetails.State) {
        if state.paths.isEmpty == false {
            viewInput.update(to: .success(state: state))
        } else if let failure = state.failure {
            viewInput.update(to: .failure(failure))
        }
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension ProjectDetails.State {
    init(appState: AppState) {
        let heaviestDependency = appState.dependencyGraphState.list.sorted(by: {
            first, second -> Bool in

            first.dependencies.count > second.dependencies.count
        }).first?.owner
        let totalDeps = appState.dependencyGraphState.list.count
        let paths = appState.dependencyPathsState.paths

        self.init(
            heaviestDependency: heaviestDependency ?? "",
            totalDependenciesFound: totalDeps,
            paths: paths,
            failure: appState.dependencyGraphState.failure
        )
    }
}

extension ProjectDetails.State: StateType {}
extension ProjectDetails.State {
    static let initialState = ProjectDetails.State(
        heaviestDependency: "",
        totalDependenciesFound: -1,
        paths: [],
        failure: nil
    )
}
