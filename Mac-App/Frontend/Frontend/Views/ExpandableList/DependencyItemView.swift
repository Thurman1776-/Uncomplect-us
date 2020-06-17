//
//  DependencyItemView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 17.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DependencyItemView: View {
    let dependency: DependencyTree.State.Dependency
    let isExpanded: Bool

    public init(dependency: DependencyTree.State.Dependency, isExpanded: Bool) {
        self.dependency = dependency
        self.isExpanded = isExpanded
    }

    public var body: some View {
        HStack {
            mainContent
        }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
    }

    private var mainContent: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Owner: \(dependency.owner)")
                    .font(.headline)
                    .foregroundColor(.lightBlue)
                Text("Dependency count: \(dependency.dependencies.count)")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(8)

            if isExpanded {
                VStack(alignment: .leading) {
                    dependencyList
                }
            }
        }
    }

    private var dependencyList: some View {
        ForEach(dependency.dependencies, id: \.id) { dep in
            Text(dep)
                .font(.body)
                .italic()
                .foregroundColor(.yellow)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
        }
    }
}
