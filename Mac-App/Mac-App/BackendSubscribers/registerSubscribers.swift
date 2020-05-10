//
//  registerSubscribers.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 03.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Frontend

func registerSubscribers() {
    BackendAPI.subscribe(listViewTransformer.stateObserver) { $0.select(DependencyTree.Data.init) }
    BackendAPI.subscribe(projectDetailsTransformer.stateObserver) { $0.select(ProjectDetails.Data.init) }

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
