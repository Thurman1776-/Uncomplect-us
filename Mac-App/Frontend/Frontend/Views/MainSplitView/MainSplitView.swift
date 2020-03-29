import SwiftUI

public struct MainSplitView: View {
    private var viewData: ObservableData<DependencyTreeView.State>
    public init(viewData: ObservableData<DependencyTreeView.State>) {
        self.viewData = viewData
    }

    public var body: some View {
        MainSplitViewController(viewData: viewData)
    }
}
