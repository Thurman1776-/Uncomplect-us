import ReSwift

public struct AppState: StateType {
    public let dependencyPathsState: DependencyPathsState
    public let swiftDepsState: SwiftDepsState
}

// MARK: - Initial state

extension AppState {
    static let initialState = AppState(
        dependencyPathsState: DependencyPathsState.initialState,
        swiftDepsState: SwiftDepsState.initialState
    )
}
