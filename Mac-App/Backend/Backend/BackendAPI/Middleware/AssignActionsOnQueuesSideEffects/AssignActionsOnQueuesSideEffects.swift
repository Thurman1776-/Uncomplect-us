//
//  AsignActionsOnQueuesSideEffects.swift
//  Backend
//
//  Created by Daniel Garcia on 24.10.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func assignActionsOnQueuesSideEffects() -> Middleware<AppState> {
    { (_: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                switch action {
                case NavigationAction.transition:
                    DispatchQueue.main.async { next(action) }
                default:
                    // Actions NEED to be dispatched from a serial queue. ReSwift does not support
                    // concurrent queues. The thread where the actions are dispatched from is what causes
                    // the state to change
                    dispatchAsyncOnSerialBackendQueue { next(action) }
                }
            }
        }
    }
}
