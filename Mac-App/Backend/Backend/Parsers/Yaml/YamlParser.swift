//
//  YamlParser.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation
import Yams

typealias YamlParserType = ([URL]) -> [SwiftDeps]

/// Parses urls that point to `.swiftdeps` YAML files into a simplified version containing
/// the owner & its dependencies
/// - Parameter urls: Array containing absolute file system urls to YAML files
/// - Returns: An array of simplefied YAML contents
func parseYamlUrls(from urls: [URL]) -> [SwiftDeps] {
    createYamlNodes(from: urls.compactMap { contentsOfFile(at: $0) }).compactMap(SwiftDeps.init)
}

private func createYamlNodes(from collection: [String]) -> [Yams.Node] {
    collection.compactMap { (try? Yams.compose(yaml: $0)) }
}

private func contentsOfFile(using fileManager: FileManager = .default, at file: URL) -> String? {
    guard isASwiftDepsFile(file) == true,
        let data = fileManager.contents(atPath: file.path),
        let contentsOfFile = String(data: data, encoding: .utf8) else {
        return nil
    }

    return contentsOfFile
}

private func isASwiftDepsFile(_ path: URL) -> Bool { path.pathExtension == swiftDepsExtension }
