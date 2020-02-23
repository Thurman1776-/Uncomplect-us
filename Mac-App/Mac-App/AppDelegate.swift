import Backend
import Frontend
import Cocoa
import ReSwift
import SwiftUI

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = MainView(viewData: subscriber.transformedData)
        BackendAPI.dispatch(DependencyPathsAction.findUrls(for: "Mac-App"))
        BackendAPI.subscribe(subscriber)

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}


final class MainViewTransformer: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    private(set) var transformedData: ObservableData<DependencyTreeView.State> = .init(publisher: .initial)

    func newState(state: AppState) {
        print(state)
        let viewData = mapAppStateToViewData(state)
        if viewData.dependencies.isEmpty == false {
            transformedData.render(DependencyTreeView.State.success(viewData: viewData))
        } else {
            transformedData.render(DependencyTreeView.State.failure)
        }
    }

    private func mapAppStateToViewData(_ appState: AppState) -> DependencyTreeView.Data {
        .init(dependencies: appState.dependencyGraphState.tree.map {
            DependencyTreeView.Data.Dependencies(
                owner: $0.owner,
                dependencies: $0.dependencies.map({ String($0.name) })
            )
        })
    }
}

let subscriber = MainViewTransformer()
