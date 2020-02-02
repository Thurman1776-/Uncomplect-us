import ReSwift

func findProjectOutputDirsSideEffects() -> Middleware<AppState> {
    return { (dispatchFuction: @escaping DispatchFunction, _: @escaping () -> AppState?) in
        { (next: @escaping DispatchFunction) in
            { action in

                next(action)
                guard action is DependencyPathsAction else { return }

                switch action {
                case let DependencyPathsAction.findUrls(for: project):
                    DispatchQueue.global(qos: .userInitiated).async {
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
