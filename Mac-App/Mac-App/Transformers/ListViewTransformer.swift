//
//  ListViewTransformer.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Cocoa
import Frontend
import ReSwift

final class ListViewTransformer: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    private(set) var transformedData: ObservableData<DependencyTreeView.State> = .init(.initial)

    func newState(state: AppState) {
        let viewData = mapAppStateToViewData(state)
        if viewData.dependencies.isEmpty == false {
            transformedData.render(.success(viewData: viewData))
        } else if let failure = state.dependencyGraphState.failure {
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
