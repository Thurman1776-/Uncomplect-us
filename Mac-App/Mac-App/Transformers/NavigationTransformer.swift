//
//  NavigationTransformer.swift
//  Mac-App
//
//  Created by Daniel Garcia on 14.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Combine
import Frontend
import ReSwift
import SwiftUI

final class NavigationTransformer: StateTransforming, StateRepresentableViewInput, StateSubscription {
    let stateObserver = StateObserver<Frontend.NavigationData.State>(state: NavigationData.State.initialState)
    let viewInput: Observable<NavigationData.Status> = .init(.initial)
    private var cancellable: AnyCancellable = AnyCancellable {}

    private let window: NSWindow
    private let listViewInput: Observable<Frontend.DependencyTree.Status>
    private let projectDetailsViewInput: Observable<Frontend.ProjectDetails.Status>

    init(
        window: NSWindow,
        listViewInput: Observable<Frontend.DependencyTree.Status>,
        projectDetailsViewInput: Observable<Frontend.ProjectDetails.Status>
    ) {
        self.window = window
        self.listViewInput = listViewInput
        self.projectDetailsViewInput = projectDetailsViewInput
    }

    func startListening() {
        cancellable = stateObserver.$currentState.sink { [weak self] in self?.emitNewState($0) }
    }

    func stopListening() {
        cancellable.cancel()
    }

    func emitNewState(_ state: NavigationData.State) {
        switch state.currentNode {
        case .startup:
            window.center()
            window.setFrameAutosaveName("Main Window")
            window.makeKeyAndOrderFront(nil)
            window.contentView = NSHostingView(rootView: InputView())
        case .input:
            // When transitioning to `input` view, transformers' view data need to switch back to
            // `initial` state for correct layout rendering
            listViewInput.update(to: .initial)
            projectDetailsViewInput.update(to: .initial)
            window.contentView = NSHostingView(rootView: InputView())
        case .mainScreen:
            let mainSplitView = MainSplitView(
                dependencyTreeStatus: listViewInput,
                projectDetailsStatus: projectDetailsViewInput
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
        case .startup:
            frontendCurrentNode = .startup
        case .input:
            frontendCurrentNode = .input
        case .mainScreen:
            frontendCurrentNode = .mainScreen
        }

        let frontendPreviousNode: Frontend.NavigationData.Node?
        let backendPreviousNode = appState.navigationState.previousNode

        switch backendPreviousNode {
        case .startup:
            frontendPreviousNode = .startup
        case .input:
            frontendPreviousNode = .input
        case .mainScreen:
            frontendPreviousNode = .mainScreen
        case .none:
            frontendPreviousNode = nil
        }

        self.init(currentNode: frontendCurrentNode, previousNode: frontendPreviousNode)
    }
}

extension Frontend.NavigationData.State: StateType {}
extension Frontend.NavigationData.State {
    static let initialState = NavigationData.State(currentNode: NavigationData.Node.startup, previousNode: nil)
}
