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
                gradient: Gradient(colors: [.gray, .blue, .yellow, .blue]),
                center: .center
            ), width: 1.0
        )
    }
}
