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
    private var projectDetailsState: ObservableData<ProjectDetails.State>

    public init(
        dependencyTreeState: ObservableData<DependencyTree.State>,
        projectDetailsState: ObservableData<ProjectDetails.State>
    ) {
        self.dependencyTreeState = dependencyTreeState
        self.projectDetailsState = projectDetailsState
    }

    public var body: some View {
        MainSplitViewController(
            dependencyTreeState: dependencyTreeState,
            projectDetailsState: projectDetailsState
        )
    }
}
