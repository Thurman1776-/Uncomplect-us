import Foundation
import OSLog

public struct Bash: Commandable {

    // MARK: - Public API

    public func execute(command: String, arguments: [String]) -> String? {
        let bashCommand = runCommand(
            command: "/bin/bash" ,
            arguments: ["-l", "-c", "which \(command)"]
        )

        func handleCommandError(_ error: Bash.Error) {
            switch error {
            case let .commandDoesNotExist(terminationCode: code):
                os_log("""
                    Command could not be found!
                    This will cause the application to not work appropriately. Have your built-in executables location
                    changed?
                    Termination code -> %s
                    """, type: .error, String(code))
            case let .noOutputFor(command: value):
                os_log("Command did not generate output! -> %s", type: .error, value)
            case let .unexpectedError(error):
                os_log("Something odd went wrong! -> %s", type: .error, error.localizedDescription)
            case let .enviromentVariableNotFound(terminationCode: code):
                os_log("""
                Enviroment variable could not be found
                This will cause the application to not work appropriately. Have your default env vars changed?
                Termination code -> %s
                """, type: .error, String(code))
            }
        }

        switch bashCommand {
        case let .success(output):
            let actualCommand = output.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            let result = runCommand(command: actualCommand, arguments: arguments)

            switch result {
            case let .success(actualCommandOutput):
                return actualCommandOutput
            case let .failure(error):
                handleCommandError(error)
                return nil
            }

        case let .failure(error):
            handleCommandError(error)
            return nil
        }
    }

    // MARK: Private API

    private func runCommand(command: String, arguments: [String] = []) -> Swift.Result<String, Bash.Error> {

        // Special cases
        var updatedArguments = arguments

        let enviromentVars = arguments.filter { $0.contains("$HOME") }
        if enviromentVars.count > 0 {
            // For now HOME is the only case
            guard let homeDir = ProcessInfo.processInfo.environment["HOME"] else {
                return .failure(.enviromentVariableNotFound(terminationCode: -1))
            }

            if let indexOfStringToReplace = updatedArguments.firstIndex(of: enviromentVars.first!),
                let argumentWithEnvVar = enviromentVars.first(where: { $0.contains("$HOME")  }) {
                updatedArguments.remove(at: indexOfStringToReplace)
                updatedArguments.insert(argumentWithEnvVar.replacingOccurrences(of: "$HOME", with: homeDir), at: indexOfStringToReplace)
            }
        }

        let exitCode = executeCommandIfAvailable(command, arguments: updatedArguments)
        guard
            exitCode == 0 else {
            return .failure(.commandDoesNotExist(terminationCode: exitCode))
        }

        let process = Process()
        process.executableURL = URL(fileURLWithPath: command)
        process.arguments = arguments

        do {
            let pipe = Pipe()
            process.standardOutput = pipe
            try process.run()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: String.Encoding.utf8) {
                return .success(output)
            } else {
                return .failure(.noOutputFor(command: command))
            }

        } catch let nserror as NSError {
            return .failure(.unexpectedError(nserror))
        }
    }

    private func executeCommandIfAvailable(_ command: String, arguments: [String] = []) -> Int32 {

        let process = Process()
        process.executableURL = URL(fileURLWithPath: command)
        process.arguments = arguments

        do {
            try process.run()
        } catch let nserror as NSError {
            return Int32(truncatingIfNeeded: nserror.code)
        }

        process.waitUntilExit()

        return process.terminationStatus
    }
}
