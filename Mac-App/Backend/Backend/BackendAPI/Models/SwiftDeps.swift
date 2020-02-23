//
//  SwiftDeps.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Yams

public struct SwiftDeps: Equatable {
    let providesTopLevel: Yams.Node.Sequence
    let dependsTopLevel: Yams.Node.Sequence

    init?(node: Yams.Node) {
        guard let providesSequence = node.mapping?["provides-top-level"]?.sequence,
            let dependsSequence = node.mapping?["depends-top-level"]?.sequence else {
            return nil
        }

        providesTopLevel = providesSequence
        dependsTopLevel = dependsSequence
    }
}
