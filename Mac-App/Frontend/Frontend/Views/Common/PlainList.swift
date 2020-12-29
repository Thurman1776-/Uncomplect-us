//
//  PlainList.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 21.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct PlainList: View {
    let titles: [String]
    let itemsColor: Color
    private let truncationMode: Text.TruncationMode

    public init(titles: [String], itemsColor: Color, truncationMode: Text.TruncationMode = .tail) {
        self.titles = titles
        self.itemsColor = itemsColor
        self.truncationMode = truncationMode
    }

    public var body: some View {
        List {
            ForEach(titles, id: \.id) { title in
                Text(title)
                    .font(.caption)
                    .italic()
                    .truncationMode(truncationMode)
                    .foregroundColor(itemsColor)
            }
        }
    }
}
