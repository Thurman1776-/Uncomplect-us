import Quick
import Nimble
@testable import Mac_App

final class ProjectOutputSpec: QuickSpec {
    override func spec() {
        describe("ProjectOutputSpec") {

            context("Given derived data paths for the project exists") {
                it("returns located folders containing dependency files as valid URLs") {
                    let output = findProjectOutputDirectory(projectName: "Mac-App")

                    expect(output).notTo(beEmpty())

                    let firstItem = output.first!
                    expect(firstItem.isFileURL).to(beTrue())
                }
            }
        }
    }
}
