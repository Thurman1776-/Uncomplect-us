import ReSwift

func parseSwiftDepsSideEffects() -> Middleware<AppState> {
    return { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is SwiftDepsAction else { return }

                switch action {
                case let SwiftDepsAction.parseFrom(paths: url):
                    DispatchQueue.global(qos: .userInitiated).async {
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
