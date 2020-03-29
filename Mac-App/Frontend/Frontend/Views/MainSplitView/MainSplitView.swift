import SwiftUI

struct MainSplitView: NSViewControllerRepresentable {
    typealias NSViewControllerType = NSSplitViewController

    func makeNSViewController(context: NSViewControllerRepresentableContext<MainSplitView>) -> NSSplitViewController {
        buildSplitViewController()
    }

    func updateNSViewController(
        _ nsViewController: NSSplitViewController,
        context: NSViewControllerRepresentableContext<MainSplitView>) { }
}

// MARK: - Helpers

private func buildSplitViewController() -> NSSplitViewController {
    let splitViewController = NSSplitViewController()
    splitViewController.addSplitViewItem(buildOptionsViewItem())
    splitViewController.addSplitViewItem(buildContentViewItem())

    let splitView = NSSplitView()
    splitView.isVertical = true
    splitView.dividerStyle = .thick
    splitViewController.splitView = splitView

    return splitViewController
}

private func buildOptionsViewItem() -> NSSplitViewItem {
    // Dummy controller temporarily
    let emptyViewController = NSViewController()
    emptyViewController.view.layer?.backgroundColor = .init(gray: 10, alpha: 1.0)
    let splitViewItem = NSSplitViewItem(viewController: emptyViewController)

    return splitViewItem
}

private func buildContentViewItem() -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: ExpandableListView(viewData: .init(.initial)))
    let splitViewItem = NSSplitViewItem(viewController: hostingController)
    return splitViewItem
}
