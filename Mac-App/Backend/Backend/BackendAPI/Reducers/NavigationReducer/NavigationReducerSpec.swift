//
//  NavigationReducerSpec.swift
//  Backend
//
//  Created by Daniel Garcia on 14.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class NavigationReducerSpec: QuickSpec {
    override func spec() {
        describe("NavigationReducerSpec") {
            let navigationState = NavigationState.initialState

            context("given NavigationAction.transition(to:) gets dispatched") {
                context("when it is on the initial state") {
                    it("then transitions to expected node") {
                        let nextNode = Node.mainScreen
                        let sut = navigationReducer
                        let newState = sut(
                            NavigationAction.transition(to: nextNode),
                            navigationState
                        )

                        expect(newState.currentNode).to(equal(.mainScreen))
                        expect(newState.previousNode).to(equal(.startup))
                    }
                }

                context("given the same node gets dispatched") {
                    it("does not transition to anything") {
                        let currentNavigationState = NavigationState(currentNode: .input, previousNode: nil)
                        let sut = navigationReducer
                        let newState = sut(
                            NavigationAction.transition(to: .input),
                            currentNavigationState
                        )

                        expect(newState.currentNode).to(equal(.input))
                        expect(newState.previousNode).to(beNil())
                    }
                }
            }
        }
    }
}

//
// context("given the navigation is on \(Node.mainScreen)") {
//
//    beforeEach {
//
//    }
//
//    context("when a ") {
//
//    }
// }
