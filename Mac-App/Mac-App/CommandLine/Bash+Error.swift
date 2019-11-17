import Foundation

extension Bash {
    enum Error: Swift.Error {
        case commandDoesNotExist(terminationCode: Int32)
        case noOutputFor(command: String)
        case unexpectedError(NSError)
    }
}
