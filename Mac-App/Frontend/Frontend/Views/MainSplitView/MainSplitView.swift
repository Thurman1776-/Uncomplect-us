//
//  MainSplitView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitView: View {
    private var dependencyTreeState: ObservableData<DependencyTree.State>
    public init(dependencyTreeState: ObservableData<DependencyTree.State>) {
        self.dependencyTreeState = dependencyTreeState
    }

    public var body: some View {
        MainSplitViewController(dependencyTreeState: dependencyTreeState)
    }
}
