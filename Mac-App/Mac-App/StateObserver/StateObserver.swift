//
//  StateObserver.swift
//  Mac-App
//
//  Created by Daniel GARCÍA on 03.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Combine
import ReSwift

final class StateObserver<State: StateType & Equatable>: StoreSubscriber {
    typealias StoreSubscriberStateType = State

    @Published
    private(set) var currentState: State

    init(state: State) {
        currentState = state
    }

    // MARK: - Public API

    func newState(state: State) {
        guard currentState != state else { return }

        currentState = state
    }
}
