import ReSwift

// MARK: - State

public struct SwiftDepsState: Equatable {
    public var dependencies: [SwiftDeps]
}

// MARK: - Initial state

extension SwiftDepsState {
    static let initialState = SwiftDepsState(dependencies: [])
}

// MARK: - Actions

public enum SwiftDepsAction: Action {
    case parseFrom(paths: [URL])
    case set([SwiftDeps])
    case reset
    case failure(message: String)
}
