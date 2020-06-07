//
//  ListRowModifier.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 17.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct ListRowModifier: ViewModifier {
    public func body(content: Content) -> some View {
        Group {
            content
            Divider()
        }.offset(x: 20)
    }
}
