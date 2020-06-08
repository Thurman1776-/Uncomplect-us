//
//  ParseSwiftDeps.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

typealias SwiftDepsParserType = (_ swiftDeps: [SwiftDeps]) -> [DependencyTree]

/// Parses an array of `SwiftDeps` which represents a simplefied version of `.swiftDeps` YAML files
///
/// Parsing omits private declarations, ocurrances of `Self`, system symbols (see `systemSymbols` declaration)
/// as well as objects with with common framework prefixes: `NS`, `UI` & `CF` (list might need to be updated later)
///
/// - Parameter swiftDeps: An array of Swift dependencies
/// - Returns: An array of dependencies mapped in the form of: `owner -> [Dependencies]`
func parseSwiftDeps(_ swiftDeps: [SwiftDeps]) -> [DependencyTree] {
    var result = [DependencyTree]()

    swiftDeps.forEach { dep in
        dep.providesTopLevel.forEach { node in
            if let name = try? node.represented().string {
                let deps = dep.dependsTopLevel
                    .filter { $0.tag.description != "!private" }
                    .compactMap { (try? $0.represented().string) }
                    .excludeSystemSymbols()
                    .excludeSystemSymbolsPrefixes()
                    .filterOcurrancesOf(name)
                    .map(DependencyTree.Dependency.init)

                result.append(DependencyTree(owner: name, dependencies: deps))
            }
        }
    }

    return result
}
