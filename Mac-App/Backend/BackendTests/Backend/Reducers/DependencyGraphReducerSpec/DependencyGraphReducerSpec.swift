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
                it("returns (any) previous successful state") {
                    var sut = dependencyGraphReducer(
                        action: DependencyGraphAction.set([
                            DependencyTree.fixture,
                        ]),
                        state: graphState
                    )

                    let expectedOriginalState = sut

                    sut = dependencyGraphReducer(
                        action: DependencyGraphAction.failure(message: "Some terrible error"),
                        state: sut
                    )

                    expect(expectedOriginalState) == sut
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
