@testable import Backend
import Nimble
import Quick

final class YamlParserSpec: QuickSpec {
    override func spec() {
        describe("YamlParserSpec") {
            context("given it takes a valid input") {
                it("returns correctly parsed Yaml objects") {
                    let output = findProjectOutputDirectories(projectName: "Mac-App")
                    let result = parseSwiftDeps(from: output)

                    print(result)
                    expect(result).notTo(beEmpty())
                }
            }

            context("given it takes an invalid input") {
                it("returns an empty array") {
                    let result = parseSwiftDeps(from: [])

                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
