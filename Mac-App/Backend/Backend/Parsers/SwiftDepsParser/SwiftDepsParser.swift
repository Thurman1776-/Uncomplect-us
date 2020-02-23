//
//  ParseSwiftDeps.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

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
                    .map(DependencyTree.Dependency.init)

                result.append(DependencyTree(owner: name, dependencies: deps))
            }
        }
    }

    return result
}
