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
    private var projectDetailsStatus: Observable<ProjectDetails.Status>

    public init(
        dependencyTreeState: Observable<DependencyTree.State>,
        projectDetailsStatus: Observable<ProjectDetails.Status>
    ) {
        self.dependencyTreeState = dependencyTreeState
        self.projectDetailsStatus = projectDetailsStatus
    }

    public var body: some View {
        MainSplitViewController(
            dependencyTreeState: dependencyTreeState,
            projectDetailsStatus: projectDetailsStatus
        )
    }
}
