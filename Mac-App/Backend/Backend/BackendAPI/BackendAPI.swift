//
//  BackendAPI.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

public enum BackendAPI {
    private static let store: Store<AppState> = Store<AppState>(
        reducer: appReducer,
        state: AppState.initialState,
        middleware: [
            findProjectOutputDirsSideEffects(finder: findProjectOutputDirectories),
            parseSwiftDepsSideEffects(yamlParser: parseYamlUrls(from:)),
            dependencyGraphSideEffects(parser: parseSwiftDeps(_:)),
            assignActionsOnQueuesSideEffects(),
        ]
    )

    public static var state: AppState { store.state }
    public static var dispatchFunction: ReSwift.DispatchFunction { store.dispatchFunction }

    public static func dispatch(_ action: Action) {
        BackendAPI.store.dispatch(action)
    }

    public static func subscribe<S>(_ subscriber: S)
        where AppState == S.StoreSubscriberStateType, S: ReSwift.StoreSubscriber {
        BackendAPI.store.subscribe(subscriber)
    }

    public static func subscribe<SelectedState, S>(
        _ subscriber: S,
        transform: ((ReSwift.Subscription<AppState>) -> ReSwift.Subscription<SelectedState>)?
    ) where SelectedState == S.StoreSubscriberStateType, S: ReSwift.StoreSubscriber {
        BackendAPI.store.subscribe(subscriber, transform: transform)
    }
}
