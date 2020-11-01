//
//  DispatchQueue.swift
//  Backend
//
//  Created by Daniel Garcia on 28.10.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

extension DispatchQueue {
    /// This method checks current Queue's context using its key before executing the closure to prevent
    /// unnecessary thread hops
    /// - Parameters:
    ///   - key: Key assigned to a Queue
    ///   - work: Closure to be run in a thread that matches the receiver's key.
    ///   Else it is enqueued to a different Queue
    func asyncCheckingCurrentQueue(
        for key: DispatchSpecificKey<String>,
        execute work: @escaping () -> Swift.Void
    ) {
        if let _ = DispatchQueue.getSpecific(key: key) {
            work()
        } else {
            async {
                work()
            }
        }
    }
}
