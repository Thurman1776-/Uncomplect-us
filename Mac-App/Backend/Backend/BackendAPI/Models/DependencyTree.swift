public struct DependencyTree: Equatable {
    let owner: String
    let dependencies: [DependencyTree.Dependency]
}

extension DependencyTree {
    struct Dependency: Equatable {
        let name: String
    }
}
