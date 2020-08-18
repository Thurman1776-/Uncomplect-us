//
//  NavigationData.swift
//  Frontend
//
//  Created by Daniel Garcia on 14.08.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

public enum NavigationData {
    // MARK: - Navigation State

    public struct State: Equatable {
        public var currentNode: Node

        public init(currentNode: NavigationData.Node) {
            self.currentNode = currentNode
        }
    }

    public enum Node {
        case input
        case mainScreen
    }

    // MARK: - Navigation Status

    public enum Status: Equatable {
        case initial
        case failure(_ failure: String)
        case success(state: State)
    }
}
