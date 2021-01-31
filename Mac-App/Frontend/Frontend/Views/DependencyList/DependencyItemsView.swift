//
//  DependencyItemsView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 17.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DependencyItemsView: View {
    let dependency: DependencyNode.State.Dependency

    public init(dependency: DependencyNode.State.Dependency) {
        self.dependency = dependency
    }

    public var body: some View {
        HStack {
            mainContent
        }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
    }

    private var mainContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(dependency.dependencies, id: \.id) { dep in
                    Text(dep)
                        .font(.body)
                        .fontWeight(.medium)
                        .italic()
                        .foregroundColor(.yellow)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
                }
            }
        }
    }
}

struct DependencyItemsView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyItemsView(
            dependency: .init(
                owner: "Apple",
                dependencies: ["iOS", "watchOS", "macOS", "tvOS"]
            )
        )
    }
}
