@testable import Backend

func execDefaultFindCommand() -> String {
    return Bash().execute(
        command: "find", arguments: ["$HOME/Library/Developer/Xcode/DerivedData",
                                     "-name", "*Mac-App*",
                                     "-type", "d",
                                     "-exec", "find", "{}",
                                     "-name", "i386",
                                     "-o", "-name", "armv*",
                                     "-o", "-name", "x86_64",
                                     "-type", "d", ";"]
    )!
}

let BackendTestsBundle = Bundle(identifier: "Acphut.Werkstatt.BackendTests")!
