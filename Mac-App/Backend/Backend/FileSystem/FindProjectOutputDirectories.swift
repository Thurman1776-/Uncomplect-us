//
//  FindProjectOutputDirectories.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

typealias ProjectOutputFinderType = ([URL], String, [String], Commandable, Bool) -> [URL]

// MARK: - Constants

private let _Self = "Mac-App"
let swiftDepsExtension = "swiftdeps"

enum DefaultSearchValues {
    static let derivedDataPaths: [URL] = [
        URL(fileURLWithPath: "$HOME/Library/Developer/Xcode/DerivedData"),
        URL(fileURLWithPath: "$HOME/Library/Caches/appCode*/DerivedData"),
    ]

    static let targetNames: [String] = []
    static let bash: Bash = Bash()
    static let excludingTests: Bool = true
}

// MARK: - Internal API

/// Performs a shallow search of the specified project's directory and returns URLs for the contained items (.swiftdeps)
/// - Parameter derivedDataPaths: Location for Xcode derived data output. Use $HOME instead of Tilde Expansion [~]. Default value to default Xcode settings
/// - Parameter projectName: Project to be searched for
/// - Parameter targetNames: Search for particular target [NOT SUPPORTED YET]
/// - Parameter bash: Object conforming to Commandable protocol that executes CL commands
/// - Parameter excludingTests: Flag to skip file dependencies in tests [executes faster if `true`]. Defaults to true

public func findProjectOutputDirectories(
    derivedDataPaths: [URL] = [URL(fileURLWithPath: "$HOME/Library/Developer/Xcode/DerivedData"),
                               URL(fileURLWithPath: "$HOME/Library/Caches/appCode*/DerivedData")],
    projectName: String,
    targetNames _: [String] = [],
    bash: Commandable = Bash(),
    excludingTests: Bool = true
) -> [URL] { // TODO: Consider propagating up Bash.Error. What would that look like?
    guard derivedDataPaths.count > 1 else {
        preconditionFailure("At least one path is needed!")
    }

    let derivedDataPath = derivedDataPaths[0].relativeString
    let projName = projectName.isEmpty == true ? _Self : projectName
    let arguments = [
        derivedDataPath,
        "-name", "*\(projName)*",
        "-type", "d",
        "-exec", "find", "{}",
        "-name", "i386",
        "-o", "-name", "armv*",
        "-o", "-name", "x86_64",
        "-type", "d", ";",
    ]

    if let commandOutput = bash.execute(command: "find", arguments: arguments) {
        let filePaths: () -> [String] = {
            excludingTests ? parseCommandLineOutputSkippingTestFiles(commandOutput) : trimOutput(commandOutput)
        }

        return parseConcurrently(filePaths())
    }

    return []
}

// MARK: Helpers

private func trimOutput(_ output: String) -> [String] { output.split(separator: "\n").map(String.init) }

/// Apple docs - https://developer.apple.com/documentation/foundation/filemanager/1413768-contentsofdirectory

private func contentsOfDirectory(using fileManager: FileManager = .default, at path: String) -> [URL]? {
    try? fileManager
        .contentsOfDirectory(
            at: URL(fileURLWithPath: path),
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        )
}

// MARK: Experimental - Leverage multicore processing by splitting work

private func parseSequencially(_ collection: [String]) -> [URL] {
    var paths: Set<URL> = []
    for path in collection {
        if let urls = contentsOfDirectory(at: path) {
            urls.filter { $0.pathExtension == swiftDepsExtension }
                .forEach { paths.insert($0) }
        }
    }

    return Array(paths)
}

private func parseConcurrently(_ collection: [String]) -> [URL] {
    let middleIndex: Double = floor(Double(collection.count / 2))
    let firstChunk = collection.prefix(upTo: Int(middleIndex))
    let secondChunk = collection.suffix(from: Int(middleIndex))

    var paths: Set<URL> = []
    var firstChunkPaths: Set<URL> = []
    var secondChunkPaths: Set<URL> = []

    let operation = OperationQueue()
    operation.addOperation {
        for path in firstChunk {
            if let urls = contentsOfDirectory(at: path) {
                urls.filter { $0.pathExtension == swiftDepsExtension }
                    .forEach { firstChunkPaths.insert($0) }
            }
        }
    }

    operation.addOperation {
        for path in secondChunk {
            if let urls = contentsOfDirectory(at: path) {
                urls.filter { $0.pathExtension == swiftDepsExtension }
                    .forEach { secondChunkPaths.insert($0) }
            }
        }
    }

    operation.addBarrierBlock {
        paths = firstChunkPaths.union(secondChunkPaths)
    }

    operation.maxConcurrentOperationCount = 3
    operation.qualityOfService = .userInitiated
    operation.waitUntilAllOperationsAreFinished()

    return Array(paths)
}
