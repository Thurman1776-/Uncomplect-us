//
//  Commandable.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

public protocol Commandable {
    func execute(command: String, arguments: [String]) -> String?
}
