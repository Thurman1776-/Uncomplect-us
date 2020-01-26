@testable import Backend
import Nimble
import Quick

final class DependencyPathsReducerSpec: QuickSpec {
    override func spec() {
        describe("DependencyPathsReducerSpec") {
            let dependencyPathsState = DependencyPathsState.initialState

            context("when DependencyPathsAction.append gets dispatched") {
                context("given there are no paths found") {
                    it("appends no paths") {
                        let newState = dependencyPathsReducer(
                            action: DependencyPathsAction.append(paths: []),
                            state: dependencyPathsState
                        )

                        expect(newState.paths).to(beEmpty())
                    }
                }

                context("given there are paths found") {
                    it("it appends paths") {
                        let newState = dependencyPathsReducer(
                            action: DependencyPathsAction.append(paths: [URL(string: "www.coolio.com")!]),
                            state: dependencyPathsState
                        )

                        expect(newState.paths).to(haveCount(1))
                    }
                }
            }

            context("when DependencyPathsAction.remove gets dispatched with path to be removed") {
                it("it deletes specified path from array") {
                    var newState = dependencyPathsReducer(
                        action: DependencyPathsAction.append(
                            paths: [
                                URL(string: "www.coolio.com")!,
                                URL(string: "www.NOT-coolio.com")!,
                            ]
                        ),
                        state: dependencyPathsState
                    )

                    newState = dependencyPathsReducer(
                        action: DependencyPathsAction.remove(
                            paths: [URL(string: "www.coolio.com")!]
                        ), state: newState
                    )

                    expect(newState.paths).to(haveCount(1))
                    expect(newState.paths.first!.absoluteString.contains("NOT")).to(beTrue())
                }
            }

            context("when DependencyPathsAction.reset gets dispatched") {
                it("empties array") {
                    var newState = dependencyPathsReducer(
                        action: DependencyPathsAction.append(
                            paths: [
                                URL(string: "www.coolio.com")!,
                                URL(string: "www.NOT-coolio.com")!,
                            ]
                        ),
                        state: dependencyPathsState
                    )

                    newState = dependencyPathsReducer(
                        action: DependencyPathsAction.reset,
                        state: newState
                    )

                    expect(newState.paths).to(beEmpty())
                }
            }
        }
    }
}
