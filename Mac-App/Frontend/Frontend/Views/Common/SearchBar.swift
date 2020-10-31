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
    @Environment(\.dispatcher) var actionDispatcher

    public init(placeholder: String) {
        self.placeholder = placeholder
    }

    public var body: some View {
        HStack {
            TextField(
                "\(placeholder)    ",
                text: $searchText,
                onCommit: { dispatchAction() }
            )
            .padding(8)
            .padding(.horizontal, 10)
            .background(Color.lightGray)
            .cornerRadius(8)
            .onTapGesture {
                isEditing = true
                searchText = ""
            }
        }
    }

    private func dispatchAction() {
        actionDispatcher.dispatch(SearchBarAction.search(searchText))
    }
}
