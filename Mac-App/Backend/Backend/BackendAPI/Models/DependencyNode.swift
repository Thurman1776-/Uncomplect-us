//
//  DependencyNode.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

public final class DependencyNode: Equatable {
    // MARK: - Public Properties

    public let name: String
    public private(set) var dependencies: [DependencyNode]
    public weak var parent: DependencyNode?

    // MARK: - Initialisers

    public init(name: String, dependencies: [DependencyNode] = [], parent: DependencyNode? = nil) {
        self.name = name
        self.dependencies = dependencies
        self.parent = parent
    }

    // MARK: - Equatable

    public static func == (lhs: DependencyNode, rhs: DependencyNode) -> Bool {
        lhs.name == rhs.name &&
            lhs.dependencies == rhs.dependencies &&
            lhs.parent == lhs.parent
    }

    // MARK: Internal API

    func add(_ dependency: DependencyNode) {
        dependencies.append(dependency)
        dependency.parent = self
    }
}

// MARK: - Debug description

extension DependencyNode: CustomStringConvertible {
    public var description: String {
        var text = "\(name)"

        if !dependencies.isEmpty {
            text += " {" + dependencies.map { $0.description }.joined(separator: ", ") + "} "
        }

        return text
    }
}
