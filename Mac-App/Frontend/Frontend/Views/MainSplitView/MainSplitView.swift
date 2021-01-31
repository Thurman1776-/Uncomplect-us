//
//  MainSplitView.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitView: View {
    private var dependencyTreeStatus: Observable<DependencyNode.Status>
    private var projectDetailsStatus: Observable<ProjectDetails.Status>

    public init(
        dependencyTreeStatus: Observable<DependencyNode.Status>,
        projectDetailsStatus: Observable<ProjectDetails.Status>
    ) {
        self.dependencyTreeStatus = dependencyTreeStatus
        self.projectDetailsStatus = projectDetailsStatus
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            DetailsView(projectDetailsStatus: projectDetailsStatus)
            Divider()
                .foregroundColor(.gray)
            SearchableDependencyListView(dependencyTreeStatus: dependencyTreeStatus)
        }
    }
}

struct MainSplitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainSplitView(
                dependencyTreeStatus: Observable<DependencyNode.Status>(DependencyNode.Status.initial),
                projectDetailsStatus: Observable<ProjectDetails.Status>(ProjectDetails.Status.initial)
            )
            MainSplitView(
                dependencyTreeStatus: Observable<DependencyNode.Status>(
                    DependencyNode.Status.failure("Something went wrong!")
                ),
                projectDetailsStatus: Observable<ProjectDetails.Status>(
                    ProjectDetails.Status.failure("Could not find files!")
                )
            )
            MainSplitView(
                dependencyTreeStatus: Observable<DependencyNode.Status>(
                    DependencyNode.Status.success(
                        state: .init(
                            dependencies: [
                                .init(owner: "First", dependencies: ["one", "two", "three"]),
                                .init(owner: "Second", dependencies: ["one", "two", "three"]),
                                .init(owner: "Third", dependencies: ["one", "two", "three"]),
                            ],
                            filteredDependencies: [],
                            failure: ""
                        )
                    )
                ),
                projectDetailsStatus: Observable<ProjectDetails.Status>(
                    ProjectDetails.Status.success(
                        state: .init(
                            heaviestDependency: "Heaviest",
                            totalDependenciesFound: 100_000,
                            paths: [
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                                URL(string: "www.google.com")!,
                            ],
                            failure: nil
                        )
                    )
                )
            )
        }
    }
}
