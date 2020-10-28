//
//  BackendSubscription.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 03.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Cocoa
import Frontend
import ReSwift

struct BackendSubscription: StateSubscription {
    private let window: NSWindow
    private var transformers = [StateSubscription]()

    init(on window: NSWindow) {
        self.window = window
        registerSubscribers()
    }

    func startListening() {
        transformers.forEach { $0.startListening() }
    }

    func stopListening() {
        transformers.forEach { $0.stopListening() }
    }

    private mutating func registerSubscribers() {
        // MARK: - Dependency list (and its children)

        let listViewTransformer = ListViewTransformer()
        BackendAPI.subscribe(listViewTransformer.stateObserver) { appState -> Subscription<Frontend.DependencyTree.State> in
            let skippingOnSameSubState = appState.skip { $0.dependencyGraphState == $1.dependencyGraphState }
            return skippingOnSameSubState.select(Frontend.DependencyTree.State.init)
        }

        // MARK: - Project stats shown on the left hand side of the app

        let projectDetailsTransformer = ProjectDetailsTransformer()
        BackendAPI.subscribe(projectDetailsTransformer.stateObserver) { appState -> Subscription<ProjectDetails.State> in
            let skippingOnSameSubState = appState.skip { lhs, rhs -> Bool in
                lhs.dependencyGraphState == rhs.dependencyGraphState && lhs.dependencyPathsState == rhs.dependencyPathsState
            }
            return skippingOnSameSubState.select(ProjectDetails.State.init)
        }

        // MARK: - App navigation

        let navigationTransformer = NavigationTransformer(
            window: window,
            listViewInput: listViewTransformer.viewInput,
            projectDetailsViewInput: projectDetailsTransformer.viewInput
        )
        BackendAPI.subscribe(navigationTransformer.stateObserver) { appState -> Subscription<Frontend.NavigationData.State> in
            let skippingOnSameSubState = appState.skip { $0.navigationState == $1.navigationState }
            return skippingOnSameSubState.select(NavigationData.State.init)
        }

        transformers.append(listViewTransformer)
        transformers.append(projectDetailsTransformer)
        transformers.append(navigationTransformer)
    }
}
