//
//  MainViewTransformer.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Frontend
import Cocoa
import ReSwift

final class MainViewTransformer: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    private(set) var transformedData: ObservableData<DependencyTreeView.State> = .init(publisher: .initial)

    func newState(state: AppState) {
        print(state)
        let viewData = mapAppStateToViewData(state)
        if viewData.dependencies.isEmpty == false {
            transformedData.render(DependencyTreeView.State.success(viewData: viewData))
        } else {
            transformedData.render(DependencyTreeView.State.failure)
        }
    }

    private func mapAppStateToViewData(_ appState: AppState) -> DependencyTreeView.Data {
        .init(dependencies: appState.dependencyGraphState.tree.map {
            DependencyTreeView.Data.Dependencies(
                owner: $0.owner,
                dependencies: $0.dependencies.map({ String($0.name) })
            )
        })
    }
}


