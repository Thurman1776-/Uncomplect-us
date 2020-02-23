//
//  Bash+Error.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

extension Bash {
    enum Error: Swift.Error {
        case commandDoesNotExist(terminationCode: Int32)
        case noOutputFor(command: String)
        case unexpectedError(NSError)
        case enviromentVariableNotFound(terminationCode: Int32)
    }
}
