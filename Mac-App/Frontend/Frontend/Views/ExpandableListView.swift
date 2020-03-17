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
                        DependencyItem(dependency: node).onTapGesture { self.didTapItem(node) }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity))
        case let .failure(message):
            return AnyView(Text(message).frame(maxWidth: .infinity, maxHeight: .infinity))
        }
    }

    func didTapItem(_ item: DependencyTreeView.Data.Dependency) {
        print("Selected \(item.id)")
    }
}

// MARK: - Live preview

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }
