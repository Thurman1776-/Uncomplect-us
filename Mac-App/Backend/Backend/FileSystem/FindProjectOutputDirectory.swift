import Foundation

/// Finds dependency files (.swiftdeps) for the given project name
/// - Parameter derivedDataPaths: Location for Xcode derived data output. Use $HOME instead of Tilde Expansion [~]. Default value to default Xcode settings
/// - Parameter projectName: Project to be searched for
/// - Parameter targetNames: Search for particular target [NOT SUPPORTED YET]
/// - Parameter bash: Object conforming to Commandable protocol that executes CL commands

func findProjectOutputDirectory(
    derivedDataPaths: [URL] = [URL(fileURLWithPath: "$HOME/Library/Developer/Xcode/DerivedData"),
                               URL(fileURLWithPath: "$HOME/Library/Caches/appCode*/DerivedData")],
    projectName _: String,
    targetNames _: [String] = [],
    bash: Commandable = Bash()
) -> [URL] { // TODO: Consider propagating up Bash.Error. What would that look like?
    guard derivedDataPaths.count > 1 else {
        fatalError("At least one path is needed!")
    }

    let derivedDataPath = derivedDataPaths[0].relativeString
    let arguments = [
        derivedDataPath,
        "-name", "*Mac-App*",
        "-type", "d",
        "-exec", "find", "{}",
        "-name", "i386",
        "-o", "-name", "armv*",
        "-o", "-name", "x86_64",
        "-type", "d", ";",
    ]

    if let commandOutput = bash.execute(command: "find", arguments: arguments) {
        var paths: [URL] = []
        for path in trimOutput(commandOutput) {
            if let urls = contentsOfDirectory(at: path) { urls.forEach { paths.append($0) } }
        }

        return paths
    }

    return []
}

private func trimOutput(_ output: String) -> [String] { output.split(separator: "\n").map(String.init) }

private func contentsOfDirectory(using fileManager: FileManager = .default, at path: String) -> [URL]? {
    try? fileManager
        .contentsOfDirectory(
            at: URL(fileURLWithPath: path),
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        )
}
