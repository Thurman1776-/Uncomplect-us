public struct DependencyTree: Equatable {
    public let owner: String
    public let dependencies: [DependencyTree.Dependency]
}

extension DependencyTree {
    public struct Dependency: Equatable {
        public let name: String
    }
}
