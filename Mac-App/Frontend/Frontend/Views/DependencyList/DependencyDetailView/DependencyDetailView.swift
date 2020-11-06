//
//  DependencyDetailView.swift
//  Frontend
//
//  Created by Daniel Garcia on 06.11.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

struct DependencyDetailView: View {
    private let dependency: DependencyTree.State.Dependency

    init(_ dependency: DependencyTree.State.Dependency) {
        self.dependency = dependency
    }

    var body: some View {
        VStack {
            Text(dependency.owner)
                .font(.title)
                .foregroundColor(.lightBlue)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .clipped()
            Text("Dependency count: \(dependency.dependencies.count)")
                .font(.footnote)
                .foregroundColor(.gray)
            Divider()
                .foregroundColor(.white)
            DependencyItemView(dependency: dependency)
        }
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
