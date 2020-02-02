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
                        let parsedUrls = parseSwiftDeps(from: url)
                        dispatchFuction(SwiftDepsAction.set(parsedUrls))
                    }
                default: break
                }
            }
        }
    }
}
