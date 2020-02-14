import ReSwift

func dependencyGraphReducer(action: Action, state: DependencyGraphState) -> DependencyGraphState {
    guard let swiftDepsAction = action as? DependencyGraphAction else {
        return state
    }

    var newState = state

    switch swiftDepsAction {
    case let .set(deps):
        newState = DependencyGraphState(tree: deps)
    case .reset:
        newState = DependencyGraphState.initialState
    default: break
    }

    return newState
}
