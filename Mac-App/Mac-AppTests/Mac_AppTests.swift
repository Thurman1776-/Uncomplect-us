import Quick
import Nimble
@testable import Mac_App

final class TestingQuick: QuickSpec {
    override func spec() {
        describe("SampleTest") {
            it("Works!!") {
                expect(true).to(beTrue())
            }
        }
    }
}
