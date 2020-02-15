import ReSwift

func dependencyGraphSideEffects() -> Middleware<AppState> {
    return { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is DependencyGraphAction else { return }

                switch action {
                case let DependencyGraphAction.mapFrom(swiftDeps):
                    dispatchAsyncOnGlobal {
                        let parsedSwiftDeps = parseSwiftDeps(swiftDeps)
                        dispatchFuction(DependencyGraphAction.set(parsedSwiftDeps))
                    }
                default: break
                }
            }
        }
    }
}
