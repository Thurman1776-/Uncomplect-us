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

    private var viewData: ObservableData<DependencyTreeView.State>
    public init(viewData: ObservableData<DependencyTreeView.State>) {
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

private func buildSplitViewController(using viewData: ObservableData<DependencyTreeView.State>) -> NSSplitViewController {
    let splitViewController = NSSplitViewController()
    splitViewController.addSplitViewItem(buildOptionsViewItem())
    splitViewController.addSplitViewItem(buildContentViewItem(using: viewData))

    let splitView = NSSplitView()
    splitView.isVertical = true
    splitView.dividerStyle = .thick
    splitViewController.splitView = splitView

    return splitViewController
}

private func buildOptionsViewItem() -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: OptionsView())
    let splitViewItem = NSSplitViewItem(viewController: hostingController)
    splitViewItem.holdingPriority = .defaultHigh
    splitViewItem.minimumThickness = 120

    return splitViewItem
}

private func buildContentViewItem(using viewData: ObservableData<DependencyTreeView.State>) -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: ExpandableListView(viewData: viewData))
    let splitViewItem = NSSplitViewItem(viewController: hostingController)

    return splitViewItem
}
