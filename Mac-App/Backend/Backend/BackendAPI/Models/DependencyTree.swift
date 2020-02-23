//
//  DependencyTree.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

public struct DependencyTree: Equatable {
    public let owner: String
    public let dependencies: [DependencyTree.Dependency]
}

extension DependencyTree {
    public struct Dependency: Equatable {
        public let name: String
    }
}
