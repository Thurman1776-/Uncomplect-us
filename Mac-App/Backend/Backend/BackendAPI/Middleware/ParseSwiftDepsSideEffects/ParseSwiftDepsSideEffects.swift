//
//  ParseSwiftDepsSideEffects.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func parseSwiftDepsSideEffects(yamlParser: @escaping YamlParserType) -> Middleware<AppState> {
    { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is SwiftDepsAction else { return }

                switch action {
                case let SwiftDepsAction.parseFrom(paths: url):
                    dispatchAsyncOnGlobal {
                        let parsedUrls = yamlParser(url)
                        if parsedUrls.isEmpty == false {
                            dispatchFuction(SwiftDepsAction.set(parsedUrls))
                        } else {
                            dispatchFuction(DependencyGraphAction.failure(message: "Paths cold not be parsed!"))
                        }
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
