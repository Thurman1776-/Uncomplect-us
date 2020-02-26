//
//  TestUtils.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend

func execDefaultFindCommand() -> String {
    Bash().execute(
        command: "find", arguments: ["$HOME/Library/Developer/Xcode/DerivedData",
                                     "-name", "*Mac-App*",
                                     "-type", "d",
                                     "-exec", "find", "{}",
                                     "-name", "i386",
                                     "-o", "-name", "armv*",
                                     "-o", "-name", "x86_64",
                                     "-type", "d", ";"]
    )!
}

let BackendTestsBundle = Bundle(identifier: "Acphut.Werkstatt.BackendTests")!
