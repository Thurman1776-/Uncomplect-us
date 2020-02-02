@testable import Backend
import Nimble
import Quick
import Yams

final class SwiftDepsReducerSpec: QuickSpec {
    override func spec() {
        describe("SwiftDepsReducerSpec") {
            let swiftDependenciesState = SwiftDepsState.initialState

            context("when SwiftDepsAction.parse gets dispatched") {
                context("given there are no paths to parse") {
                    it("does not store anything") {
                        let newState = swiftDepsReducer(
                            action: SwiftDepsAction.parseFrom(paths: []),
                            state: swiftDependenciesState
                        )

                        expect(newState.dependencies).to(beEmpty())
                    }
                }

                context("given there are paths to parse") {
                    it("does not store anything") {
                        let newState = swiftDepsReducer(
                            action: SwiftDepsAction.parseFrom(paths: [URL(string: "www.coolio.com")!]),
                            state: swiftDependenciesState
                        )

                        expect(newState.dependencies).to(beEmpty())
                    }
                }
            }

            context("when SwiftDepsAction.set gets dispatched") {
                it("it stores parsed urls") {
                    let newState = swiftDepsReducer(
                        action: SwiftDepsAction.set([
                            SwiftDeps.AppDelegateDeps_Fixture,
                        ]),
                        state: swiftDependenciesState
                    )

                    expect(newState.dependencies).to(haveCount(1))
                }
            }

            context("when SwiftDepsAction.reset gets dispatched") {
                it("empties stored dependencies") {
                    var newState = swiftDepsReducer(
                        action: SwiftDepsAction.set([
                            SwiftDeps.AppDelegateDeps_Fixture,
                        ]),
                        state: swiftDependenciesState
                    )

                    newState = swiftDepsReducer(
                        action: SwiftDepsAction.reset,
                        state: newState
                    )

                    expect(newState.dependencies).to(beEmpty())
                }
            }

            context("when SwiftDepsAction.failure gets dispatched") {
                it("returns (any) previous successful state") {
                    var newState = swiftDepsReducer(
                        action: SwiftDepsAction.set([
                            SwiftDeps.AppDelegateDeps_Fixture,
                        ]),
                        state: swiftDependenciesState
                    )

                    let expectedOriginalState = newState

                    newState = swiftDepsReducer(
                        action: SwiftDepsAction.failure(message: "Some terrible error"),
                        state: newState
                    )

                    expect(expectedOriginalState) == newState
                }
            }
        }
    }
}

private extension SwiftDeps {
    static let AppDelegateDeps_Fixture = SwiftDeps(node: loadYamlFixture())!

    private static func loadYamlFixture() -> Yams.Node {
        let testsBundle = BackendTestsBundle
        let file = testsBundle.path(forResource: "AppDelegateSwiftDepsFixture", ofType: "swiftDeps")!
        let data = FileManager.default.contents(atPath: file)!
        let contentsOfFile = String(data: data, encoding: .utf8)!

        return try! Yams.compose(yaml: contentsOfFile)!
    }
}
