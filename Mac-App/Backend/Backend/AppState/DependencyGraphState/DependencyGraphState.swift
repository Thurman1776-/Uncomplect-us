import ReSwift

// MARK: - State

public struct DependencyGraphState: Equatable {
    public var tree: [DependencyTree]
}

// MARK: - Initial state

extension DependencyGraphState {
    static let initialState = DependencyGraphState(tree: [])
}

// MARK: - Actions

public enum DependencyGraphAction: Action {
    case mapFrom(deps: [SwiftDeps])
    case set([DependencyTree])
    case reset
    case failure(message: String)
}
