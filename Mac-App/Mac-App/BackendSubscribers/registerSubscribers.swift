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
    BackendAPI.subscribe(listViewTransformer.stateObserver) { $0.select(DependencyTreeView.Data.init) }
    BackendAPI.subscribe(detailsViewTransformer.stateObserver) { $0.select(ProjectDetails.Data.init) }

    startListening()
}

private func startListening() {
    listViewTransformer.startListening()
    detailsViewTransformer.startListening()
}

private func stopListening() {
    listViewTransformer.stopListening()
    detailsViewTransformer.stopListening()
}

// MARK: Transformers

let listViewTransformer = ListViewTransformer()
let detailsViewTransformer = DetailsViewTransformer()
