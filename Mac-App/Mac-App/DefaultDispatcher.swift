//
//  DefaultDispatcher.swift
//  Mac-App
//
//  Created by Daniel Garcia on 12.07.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Backend
import Frontend

struct DefaultDispatcher: Dispatching {
    static func dispatch(_ action: Action) {
        switch action {
        case let SearchAction.search(text):
            print("Should dispatch actions to backend from here - \(text)")
        default:
            print("Unhandled action")
        }
    }
}
