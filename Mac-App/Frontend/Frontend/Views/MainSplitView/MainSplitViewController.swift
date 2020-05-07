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

    private var viewData: ObservableData<DependencyTree.State>
    public init(viewData: ObservableData<DependencyTree.State>) {
        self.viewData = viewData
    }

    func makeNSViewController(
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) -> NSSplitViewController {
        buildSplitViewController(using: viewData)
    }

    func updateNSViewController(
        _: NSSplitViewController,
        context _: NSViewControllerRepresentableContext<MainSplitViewController>
    ) {}
}

// MARK: - Helpers

private func buildSplitViewController(using viewData: ObservableData<DependencyTree.State>) -> NSSplitViewController {
    let splitViewController = NSSplitViewController()
    splitViewController.addSplitViewItem(buildDetailsViewItem())
    splitViewController.addSplitViewItem(buildContentViewItem(using: viewData))

    let splitView = NSSplitView()
    splitView.isVertical = true
    splitView.dividerStyle = .thick
    splitViewController.splitView = splitView

    return splitViewController
}

private func buildDetailsViewItem() -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: DetailsView())
    let splitViewItem = NSSplitViewItem(viewController: hostingController)
    splitViewItem.holdingPriority = .defaultHigh
    splitViewItem.minimumThickness = 120

    return splitViewItem
}

private func buildContentViewItem(using viewData: ObservableData<DependencyTree.State>) -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: ExpandableListView(viewData: viewData))
    let splitViewItem = NSSplitViewItem(viewController: hostingController)

    return splitViewItem
}
