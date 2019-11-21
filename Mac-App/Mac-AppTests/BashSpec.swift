import Quick
import Nimble
@testable import Mac_App

final class BashSpec: QuickSpec {
    override func spec() {
        describe("BashSpec") {
            it("Returns nil for non existing command") {
                let sut = Bash()
                let result = sut.execute(command: "funky", arguments: [])
                expect(result).to(beNil())
            }

            context("given the command exist but not the option") {
                it("Returns nil") {
                    let sut = Bash()
                    let result = sut.execute(command: "ls", arguments: ["-"])
                    expect(result).to(beNil())
                }
            }

            context("given the command and the option exist") {

                it("lists files in current directory") {
                    let sut = Bash()
                    let result = sut.execute(command: "ls", arguments: ["-lh"])
                    expect(result).notTo(beNil())
                }

                it("prints current working directory") {
                    let sut = Bash()
                    let result = sut.execute(command: "pwd", arguments: ["-L"])
                    expect(result).notTo(beNil())
                }

                it("finds itself in derived data") {
                    let sut = Bash()
                    let result = sut.execute(command: "find", arguments: ["$HOME/Library/Developer/Xcode/DerivedData", "-name", "*Mac-App*"])
                    expect(result).notTo(beNil())
                }
            }
        }
    }
}

