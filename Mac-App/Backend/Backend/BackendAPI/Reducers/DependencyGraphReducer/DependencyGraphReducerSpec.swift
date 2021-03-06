//
//  DependencyGraphReducerSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class DependencyGraphReducerSpec: QuickSpec {
    override func spec() {
        describe("DependencyGraphReducerSpec") {
            let graphState = DependencyGraphState.initialState

            context("when DependencyGraphAction.mapFrom gets dispatched") {
                context("given there are no deps to map") {
                    it("does not store anything") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.mapFrom(deps: []),
                            state: graphState
                        )

                        expect(sut.tree).to(beEmpty())
                    }
                }

                context("given there are deps to map") {
                    it("does not store anything") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.mapFrom(deps: [SwiftDeps.AppDelegateDeps_Fixture]),
                            state: graphState
                        )

                        expect(sut.tree.count) == graphState.tree.count
                    }
                }
            }

            context("when DependencyGraphAction.set gets dispatched") {
                it("it stores parsed `SwiftDeps`") {
                    let expectedTree = [
                        DependencyTree.fixture,
                    ]
                    let sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set(expectedTree),
                        state: graphState
                    )

                    expect(sut.tree).to(haveCount(1))
                    expect(sut.tree).to(equal(expectedTree))
                }
            }

            context("when DependencyGraphAction.reset gets dispatched") {
                it("empties stored tree") {
                    var sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set([
                            DependencyTree.fixture,
                        ]),
                        state: graphState
                    )

                    sut = dependencyGraphReducer(
                        action: DependencyGraphAction.reset,
                        state: sut
                    )

                    expect(sut.tree).to(beEmpty())
                }
            }

            context("when DependencyGraphAction.failure gets dispatched") {
                it("returns (any) previous successful state & attached error") {
                    var sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set([
                            DependencyTree.fixture,
                        ]),
                        state: graphState
                    )

                    let originalState = sut

                    sut = dependencyGraphReducer(
                        action: DependencyGraphAction.failure(message: "Some terrible error"),
                        state: sut
                    )

                    expect(sut.tree) == originalState.tree
                    expect(sut.failure).toNot(beNil())
                }
            }

            context("when DependencyGraphAction.filter gets dispatched") {
                context("given it is a partial match") {
                    it("inserts matching search results in filtered property") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.filter(including: "w"),
                            state: DependencyGraphState.weekFixture
                        )

                        expect(sut.filteredTree).notTo(beEmpty())
                    }
                }

                context("given it is a 100% match") {
                    it("inserts matching search results in filtered property") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.filter(including: "weekdays"),
                            state: DependencyGraphState.weekFixture
                        )

                        expect(sut.filteredTree).notTo(beEmpty())
                    }
                }

                context("given it does not match any character") {
                    it("inserts nothing") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.filter(including: "hello"),
                            state: DependencyGraphState.weekFixture
                        )

                        expect(sut.filteredTree).to(beEmpty())
                    }
                }
            }
        }
    }
}

extension DependencyTree {
    static let fixture = DependencyTree(
        owner: "tests",
        dependencies: [.init(name: "test_deps")]
    )
}

extension DependencyGraphState {
    static let weekFixture = DependencyGraphState(
        tree: [
            DependencyTree(
                owner: "weekdays",
                dependencies: [
                    .init(name: "montag"),
                    .init(name: "mittwoch"),
                    .init(name: "freitag"),
                ]
            ),
            DependencyTree(
                owner: "weekends",
                dependencies: [
                    .init(name: "samstag"),
                    .init(name: "sonntag"),
                ]
            ),
        ],
        failure: nil
    )
}
