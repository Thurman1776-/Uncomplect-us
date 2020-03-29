//
//  ProjectFactsViewData.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

public enum ProjectFactsViewData {

    //MARK:- View Data

    public struct Data: Equatable {
        public let heaviestDependency: String
        public let totalDependenciesFound: Int
        public let paths: [String]
    }

    //MARK:- View State

    public enum State: Equatable {
        case initial
        case failure(_ failure: String)
        case success(viewData: Data)
    }
}
