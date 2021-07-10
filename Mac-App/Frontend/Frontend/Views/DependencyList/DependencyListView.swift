//
//  DependencyListView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct DependencyListView: View {
    @EnvironmentObject private var dependencyNodeStatus: Observable<DependencyNode.Status>
    @State private var selection: Set<DependencyNode.State.Dependency> = []

    @ViewBuilder public var body: some View {
        switch dependencyNodeStatus.input {
        case .initial:
            LoadingView(
                title: "Processing build files...",
                titleColor: .gray,
                isLoading: true
            )
            .frame(width: 200, height: 220)
        case let .success(state: state):
            NavigationView {
                VStack(alignment: .leading, spacing: 8) {
                    List {
                        if state.filteredDependencies.isEmpty {
                            renderList(using: state.dependencies)
                        } else {
                            renderList(using: state.filteredDependencies)
                        }
                    }
                    .id(UUID())
                }
            }.frame(minHeight: 200)
        case let .failure(message):
            Text(message)
                .bold()
                .foregroundColor(.gray)
                .padding([.leading, .trailing, .bottom], 8)
                .frame(minWidth: 100, minHeight: 150)
        }
    }

    // MARK: Private API

    private func renderList(using dependencies: [DependencyNode.State.Dependency]) -> some View {
        ForEach(dependencies, id: \.id) { dependency in
            NavigationLink(destination: DependencyDetailView(dependency)) {
                dependencyItem(dependency)
            }
        }
    }

    private func dependencyItem(_ dependency: DependencyNode.State.Dependency) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Owner: \(dependency.name)")
                    .font(.headline)
                    .foregroundColor(.lightBlue)
                Text("Dependency count: \(dependency.dependencies.count)")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(8)
        }
        .padding([.leading, .top, .trailing], 8)
    }
}
