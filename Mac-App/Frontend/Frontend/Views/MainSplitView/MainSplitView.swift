//
//  MainSplitView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitView: View {
    private var dependencyTreeState: Observable<DependencyTree.State>
    private var projectDetailsState: Observable<ProjectDetails.Status>

    public init(
        dependencyTreeState: Observable<DependencyTree.State>,
        projectDetailsState: Observable<ProjectDetails.Status>
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
