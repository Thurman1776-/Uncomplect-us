//
//  registerSubscribers.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 03.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend

func registerSubscribers() {
    BackendAPI.subscribe(listviewSubscriber)
    BackendAPI.subscribe(detailsViewTransformer.stateObserver)

    startListening()
}

private func startListening() {
    detailsViewTransformer.startListening()
}

private func stopListening() {
    detailsViewTransformer.stopListening()
}

// MARK: Transformers

let listviewSubscriber = ListViewTransformer()
let detailsViewTransformer = DetailsViewTransformer()
