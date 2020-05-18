//
//  ProjectDetails.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

public enum ProjectDetails {
    // MARK: - View State

    public struct State: Equatable {
        public let heaviestDependency: String
        public let totalDependenciesFound: Int
        public let paths: [URL]
        public var failure: String?

        public init(
            heaviestDependency: String,
            totalDependenciesFound: Int,
            paths: [URL],
            failure: String?
        ) {
            self.heaviestDependency = heaviestDependency
            self.totalDependenciesFound = totalDependenciesFound
            self.paths = paths
            self.failure = failure
        }
    }

    // MARK: - View Status

    public enum Status: Equatable {
        case initial
        case failure(_ failure: String)
        case success(viewData: State)
    }
}
