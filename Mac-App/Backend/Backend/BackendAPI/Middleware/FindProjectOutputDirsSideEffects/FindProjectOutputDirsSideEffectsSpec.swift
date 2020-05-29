//
//  FindProjectOutputDirsSideEffectsSpec.swift
//  BackendTests
//
//  Created by Daniel GARCÍA on 24.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick
import ReSwift

final class FindProjectOutputDirsSideEffectsSpec: QuickSpec {
    override func spec() {
        describe("findProjectOutputDirsSideEffects") {
            let sut = findProjectOutputDirsSideEffects
            var actionRecorder: [Action]!
            var dispatchFuntion: DispatchFunction!

            var nextActionRecorder: [Action]!
            var nextActionFunction: DispatchFunction!

            beforeEach {
                actionRecorder = [Action]()
                dispatchFuntion = { actionRecorder.append($0) }

                nextActionRecorder = [Action]()
                nextActionFunction = { nextActionRecorder.append($0) }

                stubbedUrls = []
            }

            afterEach {
                actionRecorder = nil
                dispatchFuntion = nil

                nextActionRecorder = nil
                nextActionFunction = nil
            }

            context("when an unrelated/arbitrary action gets dispatched") {
                it("does not trigger any action") {
                    let sutMiddleware = sut(
                        mockFindProjectOutputDirectories(derivedDataPaths:projectName:targetNames:bash:excludingTests:)
                    )
                    let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                    sideEffect(ArbitraryAction.random)

                    expect(actionRecorder.isEmpty).to(beTrue())

                    expect(nextActionRecorder.isEmpty).to(
                        beFalse(), description: "Side effects must never swallow actions!"
                    )
                }
            }

            context("when DependencyPathsAction.findUrls action gets dispatched") {
                context("given there are .swiftdeps files found") {
                    it("triggers 2 actions") {
                        let expectedNumberOfActions = 2

                        stubbedUrls = [URL(string: "www.apple.de")!]
                        let sutMiddleware = sut(
                            mockFindProjectOutputDirectories(derivedDataPaths:projectName:targetNames:bash:excludingTests:)
                        )
                        let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sideEffect(DependencyPathsAction.findUrls(for: "i_like_hummus"))

                        expect(actionRecorder.isEmpty).toEventually(beFalse(), timeout: 0.2)

                        expect(actionRecorder.count == expectedNumberOfActions).toEventually(
                            beTrue(), timeout: 0.2, description: "Expected 2 actions to have been dispatched!"
                        )

                        expect(nextActionRecorder.isEmpty).toEventually(
                            beFalse(), timeout: 0.2, description: "Side effects must never swallow actions!"
                        )
                    }
                }
            }

            context("when DependencyPathsAction.findUrls action gets dispatched") {
                context("given there are NO .swiftdeps files found") {
                    it("trigger 3 actions") {
                        let expectedNumberOfActions = 3

                        let sutMiddleware = sut(
                            mockFindProjectOutputDirectories(derivedDataPaths:projectName:targetNames:bash:excludingTests:)
                        )
                        let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sideEffect(DependencyPathsAction.findUrls(for: "i_like_hummus_mit_karotten"))

                        expect(actionRecorder.isEmpty).toEventually(beFalse(), timeout: 0.2)

                        expect(actionRecorder.count == expectedNumberOfActions).toEventually(
                            beTrue(), timeout: 0.2, description: "Expected 3 actions to have been dispatched!"
                        )

                        expect(nextActionRecorder.isEmpty).toEventually(
                            beFalse(), timeout: 0.2, description: "Side effects must never swallow actions!"
                        )
                    }
                }
            }

            context("when DependencyPathsAction.reset gets dispatched") {
                context("and the action is not handled") {
                    it("does not trigger any action") {
                        let sutMiddleware = sut(
                            mockFindProjectOutputDirectories(derivedDataPaths:projectName:targetNames:bash:excludingTests:)
                        )
                        let sideEffect = sutMiddleware(dispatchFuntion) { AppState.initialState }(nextActionFunction)
                        sideEffect(DependencyPathsAction.reset)

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

enum ArbitraryAction: Action {
    case random
}

// MARK: - Mocks & stubs

private var stubbedUrls = [URL]()
private func mockFindProjectOutputDirectories(
    derivedDataPaths _: [URL],
    projectName _: String,
    targetNames _: [String],
    bash _: Commandable,
    excludingTests _: Bool
) -> [URL] { stubbedUrls }
