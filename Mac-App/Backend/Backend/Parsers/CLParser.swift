import Foundation

func parseCommandLineOutputSkippingTestsFiles(_ output: String) -> [String] {
    guard output.isEmpty == false else { return [] }

    return output
        .components(separatedBy: "\n")
        .filter { $0.lowercased().contains("test") == false }
}
