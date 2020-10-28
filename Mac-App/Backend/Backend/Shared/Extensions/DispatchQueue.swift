//
//  DispatchQueue.swift
//  Backend
//
//  Created by Daniel Garcia on 28.10.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

extension DispatchQueue {
    func asyncWithCheck(
        key: DispatchSpecificKey<String>,
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
