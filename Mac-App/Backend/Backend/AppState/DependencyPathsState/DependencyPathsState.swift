import ReSwift

// MARK: - State

public struct DependencyPathsState {
    public var paths: [URL]
}

// MARK: - Initial state

extension DependencyPathsState {
    static let initialState = DependencyPathsState(paths: [])
}

// MARK: - Actions

public enum DependencyPathsAction: Action {
    case append(paths: [URL])
    case remove(paths: [URL])
    case reset
}
