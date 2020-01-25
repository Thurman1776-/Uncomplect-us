public protocol Commandable {
    func execute(command: String, arguments: [String]) -> String?
}
