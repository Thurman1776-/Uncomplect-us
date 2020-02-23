//
//  ParseCommandLineOutputSkippingTestFiles.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

func parseCommandLineOutputSkippingTestFiles(_ output: String) -> [String] {
    guard output.isEmpty == false else { return [] }

    return output
        .components(separatedBy: "\n")
        .filter { $0.lowercased().contains("test") == false }
}
