//
//  RunActionsOnSerialQueueSideEffects.swift
//  Backend
//
//  Created by Daniel Garcia on 24.10.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func runActionsOnSerialQueueSideEffects() -> Middleware<AppState> {
    { (_: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in
                // `ReSwift` requires state mutation (thus actions dispatch) to be serial
                // therefore, every action is enqueued in a serial background thread
                dispatchAsyncOnSerialBackendQueue { next(action) }
            }
        }
    }
}
