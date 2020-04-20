//
//  ParseSwiftDeps.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

/// Parsing omits private declarations, ocurrances of `Self`, system symbols (see `systemSymbols` declaration)
/// as well as objects with with common framework prefixes: `NS`, `UI` & `CF` (list might need to be updated later)

func parseSwiftDeps(_ swiftDeps: [SwiftDeps]) -> [DependencyTree] {
    var result = [DependencyTree]()

    swiftDeps.forEach { dep in
        dep.providesTopLevel.forEach { node in
            if let name = try? node.represented().string {
                let deps = dep.dependsTopLevel
                    .filter { $0.tag.description != "!private" }
                    .compactMap { (try? $0.represented().string) }
                    .filterOcurrancesOf(name)
                    .excludeSystemSymbols()
                    .excludeSystemSymbolsPrefixes()
                    .map(DependencyTree.Dependency.init)

                result.append(DependencyTree(owner: name, dependencies: deps))
            }
        }
    }

    return result
}
