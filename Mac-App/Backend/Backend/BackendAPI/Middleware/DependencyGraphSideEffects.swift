//
//  DependencyGraphSideEffects.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func dependencyGraphSideEffects(parser: @escaping SwiftDepsParserType) -> Middleware<AppState> {
    { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is DependencyGraphAction else { return }

                switch action {
                case let DependencyGraphAction.mapFrom(swiftDeps):
                    dispatchAsyncOnGlobal {
                        let parsedSwiftDeps = parser(swiftDeps)
                        dispatchFuction(DependencyGraphAction.set(parsedSwiftDeps))
                    }
                default: break
                }
            }
        }
    }
}
