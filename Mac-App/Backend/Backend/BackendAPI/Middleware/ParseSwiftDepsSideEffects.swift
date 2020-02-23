//
//  ParseSwiftDepsSideEffects.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func parseSwiftDepsSideEffects() -> Middleware<AppState> {
    return { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is SwiftDepsAction else { return }

                switch action {
                case let SwiftDepsAction.parseFrom(paths: url):
                    dispatchAsyncOnGlobal {
                        let parsedUrls = parseYamlUrls(from: url)
                        dispatchFuction(SwiftDepsAction.set(parsedUrls))
                    }
                case let SwiftDepsAction.set(swiftDeps):
                    dispatchAsyncOnGlobal {
                        dispatchFuction(DependencyGraphAction.mapFrom(deps: swiftDeps))
                    }
                default: break
                }
            }
        }
    }
}
