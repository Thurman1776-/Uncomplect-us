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

    private var dependencyTreeState: ObservableData<DependencyTree.State>
    private var projectDetailsState: ObservableData<ProjectDetails.State>

    public init(
        dependencyTreeState: ObservableData<DependencyTree.State>,
        projectDetailsState: ObservableData<ProjectDetails.State>
    ) {
        self.dependencyTreeState = dependencyTreeState
        self.projectDetailsState = projectDetailsState
    }

    func makeNSViewController(
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) -> NSSplitViewController {
        makeSplitViewController(using: dependencyTreeState, projectDetailsState: projectDetailsState)
    }

    func updateNSViewController(
        _: NSSplitViewController,
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) {}
}

// MARK: - Helpers

private func makeSplitViewController(
    using dependencyTreeState: ObservableData<DependencyTree.State>,
    projectDetailsState: ObservableData<ProjectDetails.State>
) -> NSSplitViewController {
    let splitViewController = NSSplitViewController()
    splitViewController.addSplitViewItem(makeDetailsView(using: projectDetailsState))
    splitViewController.addSplitViewItem(makeExpandableList(using: dependencyTreeState))

    let splitView = NSSplitView()
    splitView.isVertical = true
    splitView.dividerStyle = .thick
    splitViewController.splitView = splitView

    return splitViewController
}

private func makeDetailsView(
    using projectDetailsState: ObservableData<ProjectDetails.State>
) -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: DetailsView(projectDetailsState: projectDetailsState))
    let splitViewItem = NSSplitViewItem(viewController: hostingController)
    splitViewItem.holdingPriority = .defaultHigh
    splitViewItem.minimumThickness = 120

    return splitViewItem
}

private func makeExpandableList(
    using dependencyTreeState: ObservableData<DependencyTree.State>
) -> NSSplitViewItem {
    let hostingController = NSHostingController(
        rootView: ExpandableListView(dependencyTreeState: dependencyTreeState)
    )
    let splitViewItem = NSSplitViewItem(viewController: hostingController)

    return splitViewItem
}
