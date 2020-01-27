import ReSwift

func dependencyPathsReducer(action: Action, state: DependencyPathsState) -> DependencyPathsState {
    guard let dependencyPathsAction = action as? DependencyPathsAction else {
        return state
    }

    var newState = state

    switch dependencyPathsAction {
    case .findUrls:
        newState = DependencyPathsState.initialState
    case let .append(paths: paths):
        newState.paths = newState.paths + paths
    case let .remove(paths: paths):
        let newPaths = newState.paths.filter { paths.contains($0) == false }
        newState.paths = newPaths
    case .reset:
        newState.paths = []
    case .failure:
        return newState
    }

    return newState
}
