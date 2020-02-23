//
//  DispatchQueue+Shorthands.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

func dispatchAsyncOnGlobal(with qualityOfService: DispatchQoS.QoSClass = .userInitiated, work: @escaping () -> Void) {
    DispatchQueue.global(qos: qualityOfService).async { work() }
}
