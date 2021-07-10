//
//  DependencyGraphSideEffectsSpec.swift
//  BackendTests
//
//  Created by Daniel GARCÍA on 29.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick
import ReSwift

final class DependencyGraphSideEffectsSpec: QuickSpec {
    override func spec() {
        describe("dependencyGraphSideEffects") {
            let sut = dependencyGraphSideEffects
            var actionRecorder: [Action]!
            var dispatchFuntion: DispatchFunction!

            var nextActionRecorder: [Action]!
            var nextActionFunction: DispatchFunction!

            beforeEach {
                actionRecorder = [Action]()
                dispatchFuntion = { actionRecorder.append($0) }

                nextActionRecorder = [Action]()
                nextActionFunction = { nextActionRecorder.append($0) }
            }

            afterEach {
                actionRecorder = nil
                dispatchFuntion = nil

                nextActionRecorder = nil
                nextActionFunction = nil
            }

            context("when an unrelated action gets dispatched") {
                it("it does not trigger any action") {
                    let sutMiddleware = sut(mockSwiftDepsParser)
                    let sutSideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sutSideEffect(ArbitraryAction.random)

                    expect(actionRecorder.isEmpty).to(beTrue())
                    expect(nextActionRecorder.isEmpty).to(
                        beFalse(), description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when DependencyGraphAction.mapFrom(deps:) gets dispatched") {
                it("triggers 1 action") {
                    let sutMiddleware = sut(mockSwiftDepsParser)
                    let sutSideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sutSideEffect(DependencyGraphAction.mapFrom(deps: []))

                    expect(actionRecorder.isEmpty).toEventually(beFalse())
                    expect(nextActionRecorder.isEmpty).toEventually(
                        beFalse(), description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when DependencyGraphAction.reset gets dispatched") {
                context("and the action is not handled") {
                    it("does not trigger any action") {
                        let sutMiddleware = sut(mockSwiftDepsParser)
                        let sutSideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sutSideEffect(DependencyGraphAction.reset)

                        expect(actionRecorder.isEmpty).to(beTrue())
                        expect(nextActionRecorder.isEmpty).to(
                            beFalse(), description: "Side effects must never swallow actions!"
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Mocks

private func mockSwiftDepsParser(_: [SwiftDeps]) -> [DependencyNode] { [] }
