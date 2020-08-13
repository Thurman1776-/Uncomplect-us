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
        case let SearchAction.search(text):
            BackendAPI.dispatch(DependencyGraphAction.filter(including: text))
        default:
            os_log("Unhandled action")
        }
    }
}
