//
//  ActivityIndicator+LoadingDescription.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 15.05.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    let title: String
    @State var isloading: Bool = true

    var body: some View {
        VStack {
            ActivityIndicator(isAnimating: $isloading, style: .spinning)
                .padding()
            Text("\(title)")
                .bold()
                .foregroundColor(.gray)
                .padding()
        }
    }
}
