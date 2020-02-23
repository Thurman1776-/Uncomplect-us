//
//  ObservableData.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//


import SwiftUI

public struct MainView: View {
    @ObservedObject private var viewData: ObservableData<DependencyTreeViewState>

    public init(viewData: ObservableData<DependencyTreeViewState>) {
        self.viewData = viewData
    }

    public var body: some View {
        switch viewData.publisher {
        case .initial:
            return AnyView(Text("Processing build files...").frame(maxWidth: .infinity, maxHeight: .infinity))
        case let .success(viewData: data):
            return AnyView(VStack(alignment: .leading, spacing: 8) {
                List {
                    ForEach(data.dependencies, id: \.owner) { node in
                        VStack(alignment: .leading) {
                            Text("Owner: \(node.owner)")
                                .bold()
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Dependency count: \(node.dependencies.count)")
                                .italic()
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity))
        case .failure:
            return AnyView(Text("Something went wrong").frame(maxWidth: .infinity, maxHeight: .infinity))
        }
    }
}


// MARK: - Live preview

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }
