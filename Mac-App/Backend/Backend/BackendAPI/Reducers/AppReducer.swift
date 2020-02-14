import ReSwift

/// Unwrapping `AppState` is needed to avoid echoing of unnecessary optionality but required by `ReSwift` API
/// `AppState` always starts up with an initial value, so it's fine to unwrap

func appReducer(action: Action, state: AppState!) -> AppState {
    AppState(
        dependencyPathsState: dependencyPathsReducer(action: action, state: state.dependencyPathsState),
        swiftDepsState: swiftDepsReducer(action: action, state: state.swiftDepsState),
        dependencyGraphState: dependencyGraphReducer(action: action, state: state.dependencyGraphState)
    )
}
