//
//  DependencyTreeView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

public enum DependencyTreeView {
    // MARK: - View Data

    public struct Data: Equatable {
        public let dependencies: [Dependency]

        public init(dependencies: [Dependency]) {
            self.dependencies = dependencies.sorted(by: { $0.dependencies.count > $1.dependencies.count })
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

    // MARK: - View State

    public enum State: Equatable {
        case initial
        case failure(_ failure: String)
        case success(viewData: Data)
    }
}

extension DependencyTreeView.Data.Dependency: Hashable {}
