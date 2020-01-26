import ReSwift

func dependencyPathsReducer(action: Action, state: DependencyPathsState) -> DependencyPathsState {
    guard let dependencyPathsAction = action as? DependencyPathsAction else {
        return state
    }

    var newState = state

    switch dependencyPathsAction {
    case let DependencyPathsAction.append(paths: paths):
        newState.paths = paths
    case let DependencyPathsAction.remove(paths: paths):
        let newPaths = newState.paths.filter { paths.contains($0) == false }
        newState.paths = newPaths
    case DependencyPathsAction.reset:
        newState.paths = []
    }

    return newState
}
