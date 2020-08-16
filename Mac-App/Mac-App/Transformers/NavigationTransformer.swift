//
//  NavigationTransformer.swift
//  Mac-App
//
//  Created by Daniel Garcia on 14.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Cocoa
import Combine
import Frontend
import ReSwift
import SwiftUI

final class NavigationTransformer: StateTransforming, StateRepresentableViewInput, StateSubscription {
    let stateObserver = StateObserver<Frontend.NavigationData.State>()
    let viewInput: Observable<NavigationData.Status> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    private let window: NSWindow
    private let listViewTransformer: ListViewTransformer
    private let projectDetailsTransformer: ProjectDetailsTransformer

    init(
        window: NSWindow,
        listViewTransformer: ListViewTransformer,
        projectDetailsTransformer: ProjectDetailsTransformer
    ) {
        self.window = window
        self.listViewTransformer = listViewTransformer
        self.projectDetailsTransformer = projectDetailsTransformer
    }

    func startListening() {
        cancellable = stateObserver.$currentState.sink {
            [weak self] appState in

            precondition(appState != nil, "State observer should always have an initial state provided by the Backend!")
            self?.emitNewState(appState!)
        }
    }

    func stopListening() {
        cancellable.cancel()
    }

    func emitNewState(_ state: NavigationData.State) {
        switch state.currentNode {
        case .input: break
        case .mainScreen:
            let mainSplitView = MainSplitView(
                dependencyTreeStatus: listViewTransformer.viewInput,
                projectDetailsStatus: projectDetailsTransformer.viewInput
            )
            window.contentView = NSHostingView(rootView: mainSplitView)
        }
    }
}

// MARK: - Mapper from AppState to subscriber state (view data for UI)

extension Frontend.NavigationData.State {
    init(appState: AppState) {
        let frontendCurrentNode: Frontend.NavigationData.Node
        let backendCurrentNode = appState.navigationState.currentNode
        switch backendCurrentNode {
        case .input:
            frontendCurrentNode = .input
        case .mainScreen:
            frontendCurrentNode = .mainScreen
        }

        self.init(currentNode: frontendCurrentNode)
    }
}

extension Frontend.NavigationData.State: StateType {}
