//
//  SearchableDependencyListView.swift
//  Frontend
//
//  Created by Daniel Garcia on 09.07.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct SearchableDependencyListView: View {
    @ObservedObject private var dependencyTreeStatus: Observable<DependencyTree.Status>
    
    public init(dependencyTreeStatus: Observable<DependencyTree.Status>) {
        self.dependencyTreeStatus = dependencyTreeStatus
    }
    
    public var body: some View {
        VStack {
            SearchBar(placeholder: "Search dependencies")
                .padding(8)
            DependencyListView(dependencyTreeStatus: dependencyTreeStatus)
        }
    }
}
