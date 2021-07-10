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

                        expect(sut.list).to(beEmpty())
                    }
                }

                context("given there are deps to map") {
                    it("does not store anything") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.mapFrom(deps: [SwiftDeps.AppDelegateDeps_Fixture]),
                            state: graphState
                        )

                        expect(sut.list.count) == graphState.list.count
                    }
                }
            }

            context("when DependencyGraphAction.set gets dispatched") {
                it("it stores parsed `SwiftDeps`") {
                    let expectedNode = [
                        DependencyNode.fixture,
                    ]
                    let sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set(expectedNode),
                        state: graphState
                    )

                    expect(sut.list).to(haveCount(1))
                    expect(sut.list).to(equal(expectedNode))
                }
            }

            context("when DependencyGraphAction.reset gets dispatched") {
                it("empties stored list") {
                    var sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set([
                            DependencyNode.fixture,
                        ]),
                        state: graphState
                    )

                    sut = dependencyGraphReducer(
                        action: DependencyGraphAction.reset,
                        state: sut
                    )

                    expect(sut.list).to(beEmpty())
                }
            }

            context("when DependencyGraphAction.failure gets dispatched") {
                it("returns (any) previous successful state & attached error") {
                    var sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set([
                            DependencyNode.fixture,
                        ]),
                        state: graphState
                    )

                    let originalState = sut

                    sut = dependencyGraphReducer(
                        action: DependencyGraphAction.failure(message: "Some terrible error"),
                        state: sut
                    )

                    expect(sut.list) == originalState.list
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

                        expect(sut.filteredList).notTo(beEmpty())
                    }
                }

                context("given it is a 100% match") {
                    it("inserts matching search results in filtered property") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.filter(including: "weekdays"),
                            state: DependencyGraphState.weekFixture
                        )

                        expect(sut.filteredList).notTo(beEmpty())
                    }
                }

                context("given it does not match any character") {
                    it("inserts nothing") {
                        let sut = dependencyGraphReducer(
                            action: DependencyGraphAction.filter(including: "hello"),
                            state: DependencyGraphState.weekFixture
                        )

                        expect(sut.filteredList).to(beEmpty())
                    }
                }
            }
        }
    }
}

extension DependencyNode {
    static let fixture = DependencyNode(
        name: "tests",
        dependencies: [.init(name: "test_deps", dependencies: [])]
    )
}

extension DependencyGraphState {
    static let weekFixture = DependencyGraphState(
        list: [
            DependencyNode(
                name: "weekdays",
                dependencies: [
                    .init(name: "montag", dependencies: []),
                    .init(name: "mittwoch", dependencies: []),
                    .init(name: "freitag", dependencies: []),
                ]
            ),
            DependencyNode(
                name: "weekends",
                dependencies: [
                    .init(name: "samstag", dependencies: []),
                    .init(name: "sonntag", dependencies: []),
                ]
            ),
        ],
        failure: nil
    )
}
