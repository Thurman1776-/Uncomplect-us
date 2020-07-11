//
//  SearchBar.swift
//  Frontend
//
//  Created by Daniel Garcia on 08.07.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct SearchBar: View {
    private let placeholder: String
    @State private var searchText: String = ""
    @State private var isEditing: Bool = false

    public init(placeholder: String) {
        self.placeholder = placeholder
    }

    // FIXME: Remove print statement
    public var body: some View {
        HStack {
            TextField(
                "\(placeholder)    ",
                text: $searchText,
                onCommit: { print("Searching for: \(self.searchText)") }
            )
                .padding(8)
                .padding(.horizontal, 10)
                .background(Color.lightGray)
                .cornerRadius(8)
                .onTapGesture {
                    self.isEditing = true
                    self.searchText = ""
                }
        }
    }
}
