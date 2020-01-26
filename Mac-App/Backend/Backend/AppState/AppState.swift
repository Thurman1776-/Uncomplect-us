import ReSwift

public struct AppState: StateType {
    public let dependencyPathsState: DependencyPathsState
}

// MARK: - Initial state

extension AppState {
    static let initialState = AppState(
        dependencyPathsState: DependencyPathsState.initialState
    )
}
