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

                dispatchAsyncOnSerialBackendQueue { next(action) }
            }
        }
    }
}
