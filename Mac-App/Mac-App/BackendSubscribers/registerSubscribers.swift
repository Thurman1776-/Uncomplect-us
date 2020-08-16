//
//  registerSubscribers.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 03.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Cocoa
import Frontend

func registerSubscribers(with window: NSWindow) {
    BackendAPI.subscribe(listViewTransformer.stateObserver) { $0.select(DependencyTree.State.init) }
    BackendAPI.subscribe(projectDetailsTransformer.stateObserver) { $0.select(ProjectDetails.State.init) }

    navigationTransformer = NavigationTransformer(window: window)
    BackendAPI.subscribe(navigationTransformer.stateObserver) { $0.select(NavigationData.State.init) }

    // FIX ME: Use interfaces to call all transformer's listening functions
    navigationTransformer.startListening()

    startListening()
}

private func startListening() {
    listViewTransformer.startListening()
    projectDetailsTransformer.startListening()
}

private func stopListening() {
    listViewTransformer.stopListening()
    projectDetailsTransformer.stopListening()
}

// MARK: Transformers

let listViewTransformer = ListViewTransformer()
let projectDetailsTransformer = ProjectDetailsTransformer()
// FIXME: Move transformers to their own entity!
var navigationTransformer: NavigationTransformer!
