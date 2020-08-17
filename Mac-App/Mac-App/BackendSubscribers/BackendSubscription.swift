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
        let listViewTransformer = ListViewTransformer()
        BackendAPI.subscribe(listViewTransformer.stateObserver) { $0.select(DependencyTree.State.init) }

        let projectDetailsTransformer = ProjectDetailsTransformer()
        BackendAPI.subscribe(projectDetailsTransformer.stateObserver) { $0.select(ProjectDetails.State.init) }

        let navigationTransformer = NavigationTransformer(
            window: window,
            listViewInput: listViewTransformer.viewInput,
            projectDetailsViewInput: projectDetailsTransformer.viewInput
        )
        BackendAPI.subscribe(navigationTransformer.stateObserver) { $0.select(NavigationData.State.init) }

        transformers.append(listViewTransformer)
        transformers.append(projectDetailsTransformer)
        transformers.append(navigationTransformer)
    }
}
