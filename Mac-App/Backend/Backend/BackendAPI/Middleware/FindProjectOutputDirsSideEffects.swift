//
//  FindProjectOutputDirsSideEffects.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import ReSwift

func findProjectOutputDirsSideEffects() -> Middleware<AppState> {
    { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is DependencyPathsAction else { return }

                switch action {
                case let DependencyPathsAction.findUrls(for: project):
                    dispatchAsyncOnGlobal {
                        let urls = findProjectOutputDirectories(projectName: project)

                        if urls.isEmpty == false {
                            dispatchFuction(DependencyPathsAction.append(paths: urls))
                            dispatchFuction(SwiftDepsAction.parseFrom(paths: urls))
                        } else {
                            dispatchFuction(DependencyPathsAction.failure(message: "No paths were found!"))
                        }
                    }
                default: break
                }
            }
        }
    }
}
