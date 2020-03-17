//
//  ExpandableListView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct ExpandableListView: View {
    @ObservedObject private var viewData: ObservableData<DependencyTreeView.State>
    @State private var selection: Set<DependencyTreeView.Data.Dependency> = []

    public init(viewData: ObservableData<DependencyTreeView.State>) {
        self.viewData = viewData
    }

    public var body: some View {
        switch viewData.data {
        case .initial:
            return AnyView(
                VStack {
                    ActivityIndicator(isAnimating: Binding<Bool>.constant(true), style: .spinning)
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
                        DependencyItem(
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

    func didTapItem(_ item: DependencyTreeView.Data.Dependency) {
        if selection.contains(item) {
            selection.remove(item)
        } else {
            selection.insert(item)
        }
    }
}

// MARK: - Live preview

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }
