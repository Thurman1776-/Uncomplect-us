//
//  DefaultDispatcher.swift
//  Mac-App
//
//  Created by Daniel Garcia on 12.07.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Frontend
import OSLog

struct DefaultDispatcher: Dispatching {
    static func dispatch(_ action: Action) {
        switch action {
        case let SearchBarAction.search(text):
            BackendAPI.dispatch(DependencyGraphAction.filter(including: text))
        case let InputViewAction.search(value):
            BackendAPI.dispatch(DependencyPathsAction.findUrls(for: value))
        case FileMenuAction.newProjectSearch:
            // TODO: How could you ensure no actions would be missed when a new state leave is added?
            BackendAPI.dispatch(DependencyGraphAction.reset)
            BackendAPI.dispatch(DependencyPathsAction.reset)
            BackendAPI.dispatch(SwiftDepsAction.reset)
            BackendAPI.dispatch(NavigationAction.transition(to: .input))
        default:
            os_log("Unhandled action")
        }
    }
}
