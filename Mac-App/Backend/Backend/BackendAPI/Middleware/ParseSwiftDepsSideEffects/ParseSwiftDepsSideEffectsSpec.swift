//
//  ParseSwiftDepsSideEffectsSpec.swift
//  BackendTests
//
//  Created by Daniel GARCÍA on 25.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick
import ReSwift

final class ParseSwiftDepsSideEffectsSpec: QuickSpec {
    override func spec() {
        describe("parseSwiftDepsSideEffects") {
            let sut = parseSwiftDepsSideEffects
            var actionRecorder: [Action]!
            var dispatchFuntion: DispatchFunction!

            var nextActionRecorder: [Action]!
            var nextActionFunction: DispatchFunction!

            beforeEach {
                actionRecorder = [Action]()
                dispatchFuntion = { actionRecorder.append($0) }

                nextActionRecorder = [Action]()
                nextActionFunction = { nextActionRecorder.append($0) }

                stubbedSwiftDeps = []
            }

            afterEach {
                actionRecorder = nil
                dispatchFuntion = nil

                nextActionRecorder = nil
                nextActionFunction = nil
            }

            context("when an unrelated/arbitrary action gets dispatched") {
                it("does not dispatch any action") {
                    let sutMiddleware = sut(mockYamlParser(from:))
                    let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sideEffect(ArbitraryAction.random)

                    expect(actionRecorder.isEmpty).to(beTrue())

                    expect(nextActionRecorder.isEmpty).to(
                        beFalse(), description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when SwiftDepsAction.parseFrom action gets dispatched") {
                context("given at least one url got parsed") {
                    it("dispatches 1 action") {
                        let expectedNumberOfActions = 1

                        stubbedSwiftDeps = [SwiftDeps.AppDelegateDeps_Fixture]
                        let sutMiddleware = sut(mockYamlParser(from:))
                        let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sideEffect(SwiftDepsAction.parseFrom(paths: []))

                        expect(actionRecorder.isEmpty).toEventually(beFalse(), timeout: 0.2)

                        expect(actionRecorder.count == expectedNumberOfActions).toEventually(
                            beTrue(), timeout: 0.2, description: "Expected 1 action to have been dispatched!"
                        )

                        expect(nextActionRecorder.isEmpty).toEventually(
                            beFalse(), timeout: 0.2, description: "Side effects must never swallow actions!"
                        )
                    }
                }

                context("when NO url got parsed") {
                    it("dispatches 1 action") {
                        let expectedNumberOfActions = 1

                        stubbedSwiftDeps = []
                        let sutMiddleware = sut(mockYamlParser(from:))
                        let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sideEffect(SwiftDepsAction.parseFrom(paths: []))

                        expect(actionRecorder.isEmpty).toEventually(beFalse(), timeout: 0.2)

                        expect(actionRecorder.count == expectedNumberOfActions).toEventually(
                            beTrue(), timeout: 0.2, description: "Expected 1 action to have been dispatched!"
                        )

                        expect(nextActionRecorder.isEmpty).toEventually(
                            beFalse(), timeout: 0.2, description: "Side effects must never swallow actions!"
                        )
                    }
                }
            }

            context("when SwiftDepsAction.set action gets dispatched") {
                it("dispatches 1 action") {
                    let expectedNumberOfActions = 1

                    let sutMiddleware = sut(mockYamlParser(from:))
                    let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sideEffect(SwiftDepsAction.set([SwiftDeps.AppDelegateDeps_Fixture]))

                    expect(actionRecorder.isEmpty).toEventually(beFalse(), timeout: 0.2)

                    expect(actionRecorder.count == expectedNumberOfActions).toEventually(
                        beTrue(), timeout: 0.2, description: "Expected 1 action to have been dispatched!"
                    )

                    expect(nextActionRecorder.isEmpty).toEventually(
                        beFalse(), timeout: 0.2, description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when SwiftDepsAction gets dispatched") {
                context("and the action is not handled") {
                    it("does not dispatch any action") {
                        let sutMiddleware = sut(mockYamlParser(from:))
                        let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sideEffect(SwiftDepsAction.reset)

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

private var stubbedSwiftDeps = [SwiftDeps]()
private func mockYamlParser(from _: [URL]) -> [SwiftDeps] { stubbedSwiftDeps }
