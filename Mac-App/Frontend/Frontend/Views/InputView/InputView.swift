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
    private var output: (String) -> Void

    public init(output: @escaping (String) -> Void = { _ in }) {
        self.output = output
    }

    public var body: some View {
        TextField(
            "Type your project's name...",
            text: $input,
            onCommit: { self.output(self.input) }
        ).border(
            AngularGradient(
                gradient: Gradient(colors: randomColors()),
                center: .center
            ), width: 1.0
        ).padding(EdgeInsets(top: 45, leading: 16, bottom: 45, trailing: 16))
    }
}

private func randomColors() -> [Color] {
    var palette: [Color] = []
    for _ in 0 ... 50 {
        palette.append([.blue, .yellow, .blue, .blue, .yellow, .blue].randomElement()!)
    }

    return palette
}
