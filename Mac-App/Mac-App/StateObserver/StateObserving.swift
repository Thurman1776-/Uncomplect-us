//
//  StateObserving.swift
//  Mac-App
//
//  Created by Daniel Garcia on 16.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Frontend
import ReSwift

protocol StateObserving {
    associatedtype ObservableElement: Equatable & StateType
    var stateObserver: StateObserver<ObservableElement> { get }

    func startListening()
    func stopListening()

    func emitNewState(_ state: ObservableElement)
}

protocol ViewInput {
    associatedtype InputValue: Equatable
    var viewInput: Observable<InputValue> { get }
}
