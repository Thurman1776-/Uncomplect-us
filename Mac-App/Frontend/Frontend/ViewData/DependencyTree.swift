//
//  DependencyTree.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

public enum DependencyTree {
    // MARK: - View State

    public struct State: Equatable {
        public let dependencies: [Dependency]
        public let filteredDependencies: [Dependency]
        public let failure: String?

        public init(
            dependencies: [Dependency],
            filteredDependencies: [Dependency],
            failure: String?
        ) {
            self.dependencies = dependencies.sorted(by: { $0.dependencies.count > $1.dependencies.count })
            self.filteredDependencies = filteredDependencies.sorted(by: { $0.dependencies.count > $1.dependencies.count })
            self.failure = failure
        }

        public struct Dependency: Equatable, Identifiable {
            public var id: Int { owner.hashValue }
            let owner: String
            let dependencies: [String]

            public init(owner: String, dependencies: [String]) {
                self.owner = owner
                self.dependencies = dependencies
            }
        }
    }

    // MARK: - View Status

    public enum Status: Equatable {
        case initial
        case failure(_ failure: String)
        case success(state: State)
    }
}

extension DependencyTree.State.Dependency: Hashable {}
