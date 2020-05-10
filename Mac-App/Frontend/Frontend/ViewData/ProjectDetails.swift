//
//  ProjectDetails.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

public enum ProjectDetails {
    // MARK: - View Data

    public struct Data: Equatable {
        public let heaviestDependency: String
        public let totalDependenciesFound: Int
        public let paths: [URL]

        public init(
            heaviestDependency: String,
            totalDependenciesFound: Int,
            paths: [URL]
        ) {
            self.heaviestDependency = heaviestDependency
            self.totalDependenciesFound = totalDependenciesFound
            self.paths = paths
        }
    }

    // MARK: - View State

    public enum State: Equatable {
        case initial
        case failure(_ failure: String)
        case success(viewData: Data)
    }
}
