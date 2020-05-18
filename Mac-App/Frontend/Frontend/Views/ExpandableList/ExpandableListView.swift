//
//  ExpandableListView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct ExpandableListView: View {
    @ObservedObject private var dependencyTreeState: ObservableData<DependencyTree.State>
    @State private var selection: Set<DependencyTree.Data.Dependency> = []

    public init(dependencyTreeState: ObservableData<DependencyTree.State>) {
        self.dependencyTreeState = dependencyTreeState
    }

    public var body: some View {
        switch dependencyTreeState.data {
        case .initial:
            return AnyView(
                VStack {
                    ActivityIndicator(isAnimating: true, style: .spinning)
                        .padding()
                    Text("Processing build files...")
                        .bold()
                        .foregroundColor(.gray)
                        .padding()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        case let .success(viewData: data):
            return AnyView(VStack(alignment: .leading, spacing: 8) {
                List {
                    ForEach(data.dependencies, id: \.id) { node in
                        DependencyItemView(
                            dependency: node,
                            isExpanded: self.selection.contains(node)
                        ).onTapGesture { self.didTapItem(node) }
                            .modifier(ListRowModifier())
                            .animation(.linear(duration: 0.25))
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity))
        case let .failure(message):
            return AnyView(Text(message).frame(maxWidth: .infinity, maxHeight: .infinity))
        }
    }

    func didTapItem(_ item: DependencyTree.Data.Dependency) {
        if selection.contains(item) {
            selection.remove(item)
        } else {
            selection.insert(item)
        }
    }
}
