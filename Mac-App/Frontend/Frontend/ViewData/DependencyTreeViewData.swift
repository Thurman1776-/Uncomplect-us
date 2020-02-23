//
//  DependencyTreeViewData.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

public struct DependencyTreeViewData: Equatable {
    public let dependencies: [Dependencies]

    public init(dependencies: [Dependencies]) {
        self.dependencies = dependencies
    }

    public struct Dependencies: Equatable {
        let owner: String
        let dependencies: [String]

        public init(owner: String, dependencies: [String]) {
            self.owner = owner
            self.dependencies = dependencies
        }
    }
}


public enum DependencyTreeViewState: Equatable {
    case initial
    case failure
    case success(viewData: DependencyTreeViewData)
}
