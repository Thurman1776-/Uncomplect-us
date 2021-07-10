//
//  ParseSwiftDeps.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

typealias SwiftDepsParserType = (_ swiftDeps: [SwiftDeps]) -> [DependencyNode]

/// Parses an array of `SwiftDeps` which represents a simplified version of `.swiftDeps` YAML files
///
/// Parsing omits private declarations, occurrences of `Self`, system symbols (see `systemSymbols` declaration)
/// as well as objects with with common framework prefixes: `NS`, `UI` & `CF` (list might need to be updated later)
///
/// - Parameter swiftDeps: An array of Swift dependencies
/// - Returns: An array of dependencies mapped in the form of: `name -> [Dependencies]`
func parseSwiftDeps(_ swiftDeps: [SwiftDeps]) -> [DependencyNode] {
    var result = [DependencyNode]()

    swiftDeps.forEach { dependency in
        dependency.providesTopLevel.forEach { root in
            if let rootName = try? root.represented().string {
                
                let children = dependency.dependsTopLevel
                    .filter { $0.tag.description != "!private" }
                    .compactMap { (try? $0.represented().string) }
                    .excludeSystemSymbols()
                    .excludeSystemSymbolsPrefixes()
                    .filterOcurrancesOf(rootName)
                    .map { DependencyNode(name: $0, dependencies: []) }

                let node = DependencyNode(name: rootName)
                node.add(children)

                if result.contains(node) == false {
                    result.append(node)
                }
            }
        }
    }

    return result
}
