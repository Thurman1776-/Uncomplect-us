//
//  MainSplitViewController.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

public struct MainSplitViewController: NSViewControllerRepresentable {
    public typealias NSViewControllerType = NSSplitViewController

    private var dependencyTreeStatus: Observable<DependencyTree.Status>
    private var projectDetailsStatus: Observable<ProjectDetails.Status>

    public init(
        dependencyTreeStatus: Observable<DependencyTree.Status>,
        projectDetailsStatus: Observable<ProjectDetails.Status>
    ) {
        self.dependencyTreeStatus = dependencyTreeStatus
        self.projectDetailsStatus = projectDetailsStatus
    }

    public func makeNSViewController(
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) -> NSSplitViewController {
        makeSplitViewController(using: dependencyTreeStatus, projectDetailsStatus: projectDetailsStatus)
    }

    public func updateNSViewController(
        _: NSSplitViewController,
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) {}
}

// MARK: - Factory functions

private func makeSplitViewController(
    using dependencyTreeStatus: Observable<DependencyTree.Status>,
    projectDetailsStatus: Observable<ProjectDetails.Status>
) -> NSSplitViewController {
    let splitViewController = NSSplitViewController()
    splitViewController.addSplitViewItem(makeDetailsView(using: projectDetailsStatus))
    splitViewController.addSplitViewItem(makeExpandableList(using: dependencyTreeStatus))

    let splitView = NSSplitView()
    splitView.isVertical = true
    splitView.dividerStyle = .thick
    splitViewController.splitView = splitView

    return splitViewController
}

private func makeDetailsView(
    using projectDetailsStatus: Observable<ProjectDetails.Status>
) -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: DetailsView(projectDetailsStatus: projectDetailsStatus))
    let splitViewItem = NSSplitViewItem(viewController: hostingController)

    return splitViewItem
}

private func makeExpandableList(
    using dependencyTreeStatus: Observable<DependencyTree.Status>
) -> NSSplitViewItem {
    let hostingController = NSHostingController(
        rootView: ExpandableListView(dependencyTreeStatus: dependencyTreeStatus)
    )
    let splitViewItem = NSSplitViewItem(viewController: hostingController)

    return splitViewItem
}
