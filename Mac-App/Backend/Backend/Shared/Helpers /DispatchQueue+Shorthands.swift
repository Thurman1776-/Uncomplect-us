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

private let _backendQueue = DispatchQueue(
    label: "Acphut.Werkstatt.Backend.concurrent",
    qos: .userInitiated,
    attributes: DispatchQueue.Attributes.concurrent,
    autoreleaseFrequency: .inherit
)

func dispatchAsyncOnConcurrentBackendQueue(
    with _: DispatchQoS.QoSClass = .userInitiated,
    work: @escaping () -> Void
) {
    _backendQueue.async { work() }
}

private let _backendSerialQueue = DispatchQueue(
    label: "Acphut.Werkstatt.Backend.serial",
    qos: .userInitiated,
    autoreleaseFrequency: .inherit
)

func dispatchAsyncOnSerialBackendQueue(
    with _: DispatchQoS.QoSClass = .userInitiated,
    work: @escaping () -> Void
) {
    _backendSerialQueue.async { work() }
}
