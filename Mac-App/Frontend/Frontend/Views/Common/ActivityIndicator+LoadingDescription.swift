//
//  ActivityIndicator+LoadingDescription.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 15.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct LoadingView: View {
    let title: String
    let titleColor: Color
    @State var isloading: Bool = true

    public init(title: String, titleColor: Color, isloading: Bool) {
        self.title = title
        self.titleColor = titleColor
        self.isloading = isloading
    }

    public var body: some View {
        VStack {
            ActivityIndicator(isAnimating: $isloading, style: .spinning)
                .padding()
            Text("\(title)")
                .bold()
                .foregroundColor(titleColor)
                .padding()
        }
    }
}
