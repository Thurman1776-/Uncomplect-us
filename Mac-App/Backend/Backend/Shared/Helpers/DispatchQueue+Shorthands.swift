//
//  DispatchQueue+Shorthands.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

// MARK: - Backend concurrent queue

private let _backendConcurrentLabel = "Acphut.Werkstatt.Backend.concurrent"
private let _backendConcurrentMarker = DispatchSpecificKey<String>()
private let _backendQueue = DispatchQueue(
    label: _backendConcurrentLabel,
    qos: .userInitiated,
    attributes: DispatchQueue.Attributes.concurrent,
    autoreleaseFrequency: .inherit
)

func dispatchAsyncOnConcurrentBackendQueue(_ work: @escaping () -> Void) {
    if let _ = _backendQueue.getSpecific(key: _backendConcurrentMarker) {
        _backendQueue.asyncWithCheck(key: _backendConcurrentMarker, execute: work)
    } else {
        _backendQueue.setSpecific(key: _backendConcurrentMarker, value: _backendConcurrentLabel)
        _backendQueue.async { work() }
    }
}

// MARK: - Backend serial queue

private let _backendSerialLabel = "Acphut.Werkstatt.Backend.serial"
private let _backendSerialMarker = DispatchSpecificKey<String>()
private let _backendSerialQueue = DispatchQueue(
    label: _backendSerialLabel,
    qos: .userInitiated,
    autoreleaseFrequency: .inherit
)

func dispatchAsyncOnSerialBackendQueue(_ work: @escaping () -> Void) {
    if let _ = _backendSerialQueue.getSpecific(key: _backendSerialMarker) {
        _backendSerialQueue.asyncWithCheck(key: _backendSerialMarker, execute: work)
    } else {
        _backendSerialQueue.setSpecific(key: _backendSerialMarker, value: _backendSerialLabel)
        _backendSerialQueue.async { work() }
    }
}
