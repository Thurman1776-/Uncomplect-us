//
//  DependencyPathsReducerSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

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

                context("given there are already paths found") {
                    it("it appends paths") {
                        var newState = dependencyPathsReducer(
                            action: DependencyPathsAction.append(paths: [URL(string: "www.coolio.com")!]),
                            state: dependencyPathsState
                        )

                        newState = dependencyPathsReducer(
                            action: DependencyPathsAction.append(paths: [URL(string: "www.appending.com")!]),
                            state: newState
                        )

                        expect(newState.paths).to(haveCount(2))
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

            context("when DependencyPathsAction.findUrls gets dispatched") {
                it("creates a fresh State") {
                    let newState = dependencyPathsReducer(
                        action: DependencyPathsAction.findUrls(for: "Mac-App"),
                        state: dependencyPathsState
                    )

                    expect(newState) == dependencyPathsState
                }
            }

            context("when DependencyPathsAction.failure gets dispatched") {
                it("returns previous successful state & attached error") {
                    var newState = dependencyPathsReducer(
                        action: DependencyPathsAction.append(
                            paths: [
                                URL(string: "www.error.com")!,
                            ]
                        ),
                        state: dependencyPathsState
                    )

                    let expectedOriginalState = newState

                    newState = dependencyPathsReducer(
                        action: DependencyPathsAction.failure(message: "Some cool error"),
                        state: newState
                    )

                    expect(newState.paths) == expectedOriginalState.paths
                    expect(newState.failure).notTo(beNil())
                }
            }
        }
    }
}
