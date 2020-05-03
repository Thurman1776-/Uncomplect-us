//
//  StateObserver.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 03.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift
import Backend

final class StateObserver: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    @Published
    private(set) var currentState: AppState!

    func newState(state: AppState) {
        guard currentState != state else { return }

        currentState = state
    }
}

