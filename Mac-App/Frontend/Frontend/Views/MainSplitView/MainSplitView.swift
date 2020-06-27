//
//  MainSplitView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitView: View {
    private var dependencyTreeStatus: Observable<DependencyTree.Status>
    private var projectDetailsStatus: Observable<ProjectDetails.Status>

    public init(
        dependencyTreeStatus: Observable<DependencyTree.Status>,
        projectDetailsStatus: Observable<ProjectDetails.Status>
    ) {
        self.dependencyTreeStatus = dependencyTreeStatus
        self.projectDetailsStatus = projectDetailsStatus
    }

    public var body: some View {
        MainSplitViewController(
            dependencyTreeStatus: dependencyTreeStatus,
            projectDetailsStatus: projectDetailsStatus
        )
    }
}
