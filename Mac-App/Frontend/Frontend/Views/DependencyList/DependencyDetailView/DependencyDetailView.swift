//
//  DependencyDetailView.swift
//  Frontend
//
//  Created by Daniel Garcia on 06.11.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

struct DependencyDetailView: View {
    private let dependency: DependencyNode.State.Dependency

    init(_ dependency: DependencyNode.State.Dependency) {
        self.dependency = dependency
    }

    var body: some View {
        VStack {
            Text(dependency.owner)
                .font(.title)
                .foregroundColor(.lightBlue)
                .cornerRadius(3.0)
                .clipped()
            Text("Dependency count: \(dependency.dependencies.count)")
                .font(.footnote)
                .foregroundColor(.gray)
            Divider()
                .foregroundColor(.white)
            DependencyItemsView(dependency: dependency)
        }.frame(minWidth: 220, maxWidth: 280)
    }
}

struct DependencyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DependencyDetailView(
                .init(
                    owner: "Apple",
                    dependencies: ["iOS", "watchOS", "macOS", "tvOS"]
                )
            )
        }
    }
}
