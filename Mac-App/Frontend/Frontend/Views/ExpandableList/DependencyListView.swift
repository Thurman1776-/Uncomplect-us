//
//  DependencyListView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DependencyListView: View {
    @ObservedObject private var dependencyTreeStatus: Observable<DependencyTree.Status>
    @State private var selection: Set<DependencyTree.State.Dependency> = []

    public init(dependencyTreeStatus: Observable<DependencyTree.Status>) {
        self.dependencyTreeStatus = dependencyTreeStatus
    }

    public var body: some View {
        switch dependencyTreeStatus.input {
        case .initial:
            return AnyView(
                LoadingView(
                    title: "Processing build files...",
                    titleColor: .gray,
                    isLoading: true
                ).frame(width: 200, height: 250)
            )
        case let .success(state: state):
            return AnyView(
                VStack(alignment: .leading, spacing: 8) {
                    List {
                        ForEach(state.dependencies, id: \.id) { node in
                            DependencyItemView(
                                dependency: node,
                                isExpanded: self.selection.contains(node)
                            ).onTapGesture { self.didTapItem(node) }
                                .modifier(ListRowModifier())
                                .animation(.linear(duration: 0.25))
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        case let .failure(message):
            return AnyView(
                Text(message)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
    }

    private func didTapItem(_ item: DependencyTree.State.Dependency) {
        if selection.contains(item) {
            selection.remove(item)
        } else {
            selection.insert(item)
        }
    }
}
