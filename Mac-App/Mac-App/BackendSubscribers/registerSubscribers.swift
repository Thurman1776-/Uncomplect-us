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

    startListening()
}

private func startListening() {
}

private func stopListening() {
}

// MARK: Transformers

let listviewSubscriber = ListViewTransformer()
