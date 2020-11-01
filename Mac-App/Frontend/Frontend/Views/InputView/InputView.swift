//
//  InputView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 06.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct InputView: View {
    @State private var input: String = ""
    @Environment(\.dispatcher) var actionDispatcher

    public init() {}

    public var body: some View {
        TextField(
            "Type your project's name...",
            text: $input,
            onCommit: {
                guard input.isEmpty == false else { return }
                actionDispatcher.dispatch(InputViewAction.search(input))
                // FIX ME: When the view gets removed from its parent, this closure is run twice
                // causing the following undesired side effect:
                // 1. `InputViewAction.search(input)` gets dispatched twice. Effectively duplicating results
                // It seems this is a common issue with TextFields when they get removed from the hierarchy
                // Same happens with `SearchBar` - A proper solution for all cases needs to be thought of
                input = ""
            }
        ).border(
            AngularGradient(
                gradient: Gradient(colors: randomColors()),
                center: .center
            ), width: 1.0
        ).frame(width: 700, height: 50, alignment: .center)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}

private func randomColors() -> [Color] {
    var palette: [Color] = []
    for _ in 0 ... 50 {
        palette.append([.blue, .yellow, .blue, .blue, .yellow, .blue].randomElement()!)
    }

    return palette
}
