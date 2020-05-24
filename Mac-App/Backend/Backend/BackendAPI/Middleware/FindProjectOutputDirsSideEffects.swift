//
//  FindProjectOutputDirsSideEffects.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func findProjectOutputDirsSideEffects(finder: @escaping ProjectOutputFinderType) -> Middleware<AppState> {
    { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is DependencyPathsAction else { return }

                switch action {
                case let DependencyPathsAction.findUrls(for: project):
                    dispatchAsyncOnGlobal {
                        let urls = finder(
                            DefaultSearchValues.derivedDataPaths,
                            project,
                            DefaultSearchValues.targetNames,
                            DefaultSearchValues.bash,
                            DefaultSearchValues.excludingTests
                        )

                        if urls.isEmpty == false {
                            dispatchFuction(DependencyPathsAction.append(paths: urls))
                            dispatchFuction(SwiftDepsAction.parseFrom(paths: urls))
                        } else {
                            dispatchError("No paths were found!", with: dispatchFuction)
                        }
                    }
                default: break
                }
            }
        }
    }
}

private func dispatchError(_ message: String, with dispatchFuction: @escaping DispatchFunction) {
    dispatchFuction(DependencyPathsAction.failure(message: message))
    dispatchFuction(SwiftDepsAction.failure(message: message))
    dispatchFuction(DependencyGraphAction.failure(message: message))
}
