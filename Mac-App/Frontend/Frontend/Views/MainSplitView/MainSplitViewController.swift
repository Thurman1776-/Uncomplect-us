import SwiftUI

struct MainSplitViewController: NSViewControllerRepresentable {
    typealias NSViewControllerType = NSSplitViewController

    // Maybe a good place for @enviroment??
    private var viewData: ObservableData<DependencyTreeView.State>
    public init(viewData: ObservableData<DependencyTreeView.State>) {
        self.viewData = viewData
    }

    func makeNSViewController(context _: NSViewControllerRepresentableContext<MainSplitViewController>) -> NSSplitViewController {
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
    // Dummy controller temporarily
    let emptyViewController = NSViewController()
    emptyViewController.view.layer?.backgroundColor = .init(gray: 10, alpha: 1.0)
    let splitViewItem = NSSplitViewItem(viewController: emptyViewController)

    return splitViewItem
}

private func buildContentViewItem(using viewData: ObservableData<DependencyTreeView.State>) -> NSSplitViewItem {
    let hostingController = NSHostingController(rootView: ExpandableListView(viewData: viewData))
    let splitViewItem = NSSplitViewItem(viewController: hostingController)
    return splitViewItem
}
