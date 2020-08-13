//
//  DependencyListView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DependencyListView: View {
    @EnvironmentObject private var dependencyTreeStatus: Observable<DependencyTree.Status>
    @State private var selection: Set<DependencyTree.State.Dependency> = []

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
                        if state.filteredDependencies.isEmpty {
                            renderList(using: state.dependencies)
                        } else {
                            renderList(using: state.filteredDependencies)
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

    private func renderList(using dependencies: [DependencyTree.State.Dependency]) -> some View {
        ForEach(dependencies, id: \.id) { dependency in
            DependencyItemView(
                dependency: dependency,
                isExpanded: self.shouldExpandCell(dependency)
            ).onTapGesture { self.didTapItem(dependency) }
                .modifier(ListRowModifier())
                .animation(.linear(duration: 0.25))
        }
    }

    private func didTapItem(_ item: DependencyTree.State.Dependency) {
        if selection.contains(item) {
            selection.remove(item)
        } else {
            selection.insert(item)
        }
    }

    private func shouldExpandCell(_ dependency: DependencyTree.State.Dependency) -> Bool {
        selection.contains(dependency)
    }
}
