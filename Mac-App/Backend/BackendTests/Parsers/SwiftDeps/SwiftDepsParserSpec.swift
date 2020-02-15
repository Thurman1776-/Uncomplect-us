@testable import Backend
import Nimble
import Quick

final class SwiftDepsParserSpec: QuickSpec {
    override func spec() {
        describe("parseSwiftDeps") {
            context("given it takes a valid input") {
                it("returns correctly parsed DependencyTree objects") {
                    let result = parseSwiftDeps(
                        parseYamlUrls(
                            from: findProjectOutputDirectories(projectName: "Backend")
                        )
                    )

                    expect(result).notTo(beEmpty())
                }
            }

            context("given it takes an invalid input") {
                it("returns an empty array") {
                    let result = parseSwiftDeps([])

                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
