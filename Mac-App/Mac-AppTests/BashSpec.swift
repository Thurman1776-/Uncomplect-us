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

            context("given the command & the option exist") {
                it("Returns valid output") {
                    let sut = Bash()
                    let result = sut.execute(command: "ls", arguments: ["-l"])
                    expect(result).notTo(beNil())
                }
            }
        }
    }
}

