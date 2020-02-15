
func parseSwiftDeps(_ swiftDeps: [SwiftDeps]) -> [DependencyTree] {
    var result = [DependencyTree]()

    swiftDeps.forEach { dep in
        dep.providesTopLevel.forEach { node in
            if let name = try? node.represented().string {
                let deps = dep.dependsTopLevel
                    .compactMap { (try? $0.represented().string) }
                    .filter { $0 != name }
                    .map { DependencyTree.Dependency(name: $0) }

                result.append(DependencyTree(owner: name, dependencies: deps))
            }
        }
    }

    return result
}
