import Foundation

private let _Self = "Mac-App"
let swiftDepsExtension = "swiftdeps"

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

        var paths: [URL] = []
        for path in filePaths() {
            if let urls = contentsOfDirectory(at: path) {
                urls.filter { $0.pathExtension == swiftDepsExtension }
                    .forEach { paths.append($0) }
            }
        }

        return paths
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
