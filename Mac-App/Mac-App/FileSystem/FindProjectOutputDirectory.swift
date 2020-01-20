import Foundation

//Ruby implementation
// def find_project_output_directory(derived_data_paths, project_prefix, project_suffix_pattern, target_names, verbose)

// Command to execute
//find ~/Library/Developer/Xcode/DerivedData -depth 1 -name "Client-*" -type d -exec find {} -name "i386" -o -name "armv*" -o -name "x86_64" -type d \;

func findProjectOutputDirectory(
    derivedDataPaths: [URL] = [URL(fileURLWithPath: "$HOME/Library/Developer/Xcode/DerivedData"),
                               URL(fileURLWithPath: "$HOME/Library/Caches/appCode*/DerivedData")],
    projectName: String,
    targetNames: [String] = [],
    verbose: Bool = false,
    bash: Commandable = Bash()
) -> [URL] // Consider propagating up Bash.Error. What would that look like?
{
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
        "-type", "d", ";"
    ]

    if let commandOutput = bash.execute(command: "find", arguments: arguments) {
        var paths: [URL] = []
        for path in trimOutput(commandOutput) {
            if let url = contentsOfDirectory(at: path) {
                paths.append(url)
            }
        }

        return paths
    }

    return []
}

private func trimOutput(_ output: String) -> [String] {
    []
}

func contentsOfDirectory(using fileManager: FileManager = .default, at path: String) -> URL? {
    nil
}
