//
//  SearchableDependencyListView.swift
//  Frontend
//
//  Created by Daniel Garcia on 09.07.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct SearchableDependencyListView: View {
    @ObservedObject private var dependencyNodeStatus: Observable<DependencyNode.Status>

    public init(dependencyNodeStatus: Observable<DependencyNode.Status>) {
        self.dependencyNodeStatus = dependencyNodeStatus
    }

    public var body: some View {
        VStack {
            SearchBar(placeholder: "Filter dependencies")
                .padding(8)
            DependencyListView().environmentObject(dependencyNodeStatus)
        }
    }
}
