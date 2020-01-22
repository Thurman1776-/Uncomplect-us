@testable import Mac_App
import Nimble
import Quick

final class CLParserSpec: QuickSpec {
    override func spec() {
        describe("CLParserSpec") {
            context("given it takes a valid input") {
                it("returns a fully mapped array version exluding tests paths") {
                    let result = parseCommandLineOutput(execFindCommand())

                    expect(result).notTo(beEmpty())
                    let testsPaths = result.filter { $0.lowercased().contains("test") == true }
                    expect(testsPaths).to(beEmpty())
                }
            }

            context("given it takes an invalid input") {
                it("returns an empty array") {
                    let result = parseCommandLineOutput("")

                    expect(result).to(beEmpty())
                }
            }
        }
    }
}

private func execFindCommand() -> String {
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
