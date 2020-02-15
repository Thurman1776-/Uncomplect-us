/// Parsing omits private declarations, ocurrances of `Self`, system symbols (see `systemSymbols` declarion)
/// and objects with `NS` prefix

func parseSwiftDeps(_ swiftDeps: [SwiftDeps]) -> [DependencyTree] {
    var result = [DependencyTree]()

    swiftDeps.forEach { dep in
        dep.providesTopLevel.forEach { node in
            if let name = try? node.represented().string {
                let deps = dep.dependsTopLevel
                    .filter { $0.tag.description != "!private" }
                    .compactMap { (try? $0.represented().string) }
                    .filter { $0 != name }
                    .filter { systemSymbols.contains($0) == false }
                    .filter { $0.contains("NS") == false }
                    .map { DependencyTree.Dependency(name: $0) }

                result.append(DependencyTree(owner: name, dependencies: deps))
            }
        }
    }

    return result
}
