//
//  DispatchQueue+Shorthands.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

// MARK: - Backend concurrent queue

private let _backendConcurrentLabel = "Acphut.Werkstatt.Backend.concurrent"
private let _backendMarkerConcurrentQueue = DispatchSpecificKey<String>()
private let _backendQueue = DispatchQueue(
    label: _backendConcurrentLabel,
    qos: .userInitiated,
    attributes: DispatchQueue.Attributes.concurrent,
    autoreleaseFrequency: .inherit
)

func dispatchAsyncOnConcurrentBackendQueue(
    with _: DispatchQoS.QoSClass = .userInitiated,
    work: @escaping () -> Void
) {
    if let _ = _backendQueue.getSpecific(key: _backendMarkerConcurrentQueue) {
        _backendQueue.asyncWithCheck(key: _backendMarkerConcurrentQueue, execute: work)
    } else {
        _backendQueue.setSpecific(key: _backendMarkerConcurrentQueue, value: _backendConcurrentLabel)
        _backendQueue.async { work() }
    }
}

// MARK: - Backend serial queue

private let _backendSerialLabel = "Acphut.Werkstatt.Backend.serial"
private let _backendMarkerSerialQueue = DispatchSpecificKey<String>()
private let _backendSerialQueue = DispatchQueue(
    label: _backendSerialLabel,
    qos: .userInitiated,
    autoreleaseFrequency: .inherit
)

func dispatchAsyncOnSerialBackendQueue(
    with _: DispatchQoS.QoSClass = .userInitiated,
    work: @escaping () -> Void
) {
    if let _ = _backendSerialQueue.getSpecific(key: _backendMarkerSerialQueue) {
        _backendSerialQueue.asyncWithCheck(key: _backendMarkerSerialQueue, execute: work)
    } else {
        _backendSerialQueue.setSpecific(key: _backendMarkerSerialQueue, value: _backendSerialLabel)
        _backendSerialQueue.async { work() }
    }
}
