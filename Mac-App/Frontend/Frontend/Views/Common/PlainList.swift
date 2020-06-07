//
//  PlainList.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 21.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct PlainList: View {
    let title: [String]
    let itemsColor: Color

    public var body: some View {
        List {
            ForEach(title, id: \.id) { title in
                Text(title)
                    .font(.caption)
                    .italic()
                    .foregroundColor(self.itemsColor)
            }
        }
    }
}
