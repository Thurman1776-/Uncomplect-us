//
//  DependencyNode.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

public struct DependencyNode: Equatable {
    public let name: String
    public let dependencies: [DependencyNode]
}
