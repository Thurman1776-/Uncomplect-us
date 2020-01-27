import ReSwift

// MARK: - State

public struct DependencyPathsState: Equatable {
    public var paths: [URL]
}

// MARK: - Initial state

extension DependencyPathsState {
    static let initialState = DependencyPathsState(paths: [])
}

// MARK: - Actions

public enum DependencyPathsAction: Action {
    case findUrls(for: String)
    case append(paths: [URL])
    case remove(paths: [URL])
    case reset
    case failure(message: String)
}
