//
//  MainSplitViewController.swift
//  Frontend
//
//  Created by Daniel GARCÍA on 29.03.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import SwiftUI

struct MainSplitViewController: NSViewControllerRepresentable {
    typealias NSViewControllerType = NSSplitViewController

    private var dependencyTreeState: Observable<DependencyTree.State>
    private var projectDetailsStatus: Observable<ProjectDetails.Status>

    public init(
        dependencyTreeState: Observable<DependencyTree.State>,
        projectDetailsStatus: Observable<ProjectDetails.Status>
    ) {
        self.dependencyTreeState = dependencyTreeState
        self.projectDetailsStatus = projectDetailsStatus
    }

    func makeNSViewController(
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) -> NSSplitViewController {
        makeSplitViewController(using: dependencyTreeState, projectDetailsStatus: projectDetailsStatus)
    }

    func updateNSViewController(
        _: NSSplitViewController,
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) {}
}

// MARK: - Factory functions

private func makeSplitViewController(
    using dependencyTreeState: Observable<DependencyTree.State>,
    projectDetailsStatus: Observable<ProjectDetails.Status>
) -> NSSplitViewController {
    let splitViewController = NSSplitViewController()
    splitViewController.addSplitViewItem(makeDetailsView(using: projectDetailsStatus))
    splitViewController.addSplitViewItem(makeExpandableList(using: dependencyTreeState))

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
    using dependencyTreeState: Observable<DependencyTree.State>
) -> NSSplitViewItem {
    let hostingController = NSHostingController(
        rootView: ExpandableListView(dependencyTreeState: dependencyTreeState)
    )
    let splitViewItem = NSSplitViewItem(viewController: hostingController)

    return splitViewItem
}
