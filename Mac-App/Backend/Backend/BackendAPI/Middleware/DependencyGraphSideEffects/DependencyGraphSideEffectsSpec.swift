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
        describe("DependencyGraphSideEffects") {
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
                it("it does not dispatch any action") {
                    let sutMiddleware = sut(mockswiftDepsParser(_:))
                    let sutSideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sutSideEffect(ArbitraryAction.random)

                    expect(actionRecorder.isEmpty).to(beTrue())
                    expect(nextActionRecorder.isEmpty).to(
                        beFalse(), description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when DependencyGraphAction gets dispatched") {
                it("dispatches 1 action") {
                    let sutMiddleware = sut(mockswiftDepsParser(_:))
                    let sutSideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sutSideEffect(DependencyGraphAction.mapFrom(deps: []))

                    expect(actionRecorder.isEmpty).toEventually(beFalse())
                    expect(nextActionRecorder.isEmpty).toEventually(
                        beFalse(), description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when DependencyGraphAction gets dispatched") {
                context("and the action is not handled") {
                    it("does not dispatch any action") {
                        let sutMiddleware = sut(mockswiftDepsParser(_:))
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

// MARK: - Mocks & stubs

private func mockswiftDepsParser(_: [SwiftDeps]) -> [DependencyTree] { [] }